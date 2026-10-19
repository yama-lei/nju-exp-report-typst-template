"""Compile the package using an isolated local registry, not the user's registry."""

import json
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import tomllib
import unittest

ROOT = Path(__file__).resolve().parents[1]


class PackageTests(unittest.TestCase):
    @classmethod
    def run_command(cls, *args, cwd=None):
        result = subprocess.run(
            [str(arg) for arg in args],
            cwd=cwd or cls.work,
            env=cls.env,
            text=True,
            capture_output=True,
            timeout=90,
        )
        if result.returncode:
            raise AssertionError(
                f"Command failed: {args}\n{result.stdout}\n{result.stderr}"
            )
        return result.stdout

    @classmethod
    def setUpClass(cls):
        if not shutil.which("typst"):
            raise RuntimeError("Install Typst >= 0.14.2 before running the tests.")
        cls.temp = tempfile.TemporaryDirectory(prefix="nju-typst-tests-")
        cls.addClassCleanup(cls.temp.cleanup)
        cls.work = Path(cls.temp.name)
        cls.env = os.environ.copy()
        cls.env.pop("TYPST_ROOT", None)
        cls.env["TYPST_PACKAGE_PATH"] = str(cls.work / "packages")
        cls.env["TYPST_PACKAGE_CACHE_PATH"] = str(cls.work / "cache")
        cls.manifest = tomllib.loads((ROOT / "typst.toml").read_text())
        package = cls.manifest["package"]
        cls.spec = f"@local/{package['name']}:{package['version']}"
        cls.bundle = (
            cls.work / "packages" / "local" / package["name"] / package["version"]
        )
        # Intentionally run from outside the repository to check path handling.
        cls.run_command("bash", ROOT / "scripts/package", "packages/local")
        cls.project = cls.work / "report"
        cls.run_command("typst", "init", cls.spec, cls.project)

    def compile(self, source, name, *extra):
        target = self.work / f"{name}.pdf"
        self.run_command("typst", "compile", *extra, source, target)
        self.assertTrue(target.read_bytes().startswith(b"%PDF-"))

    def test_manifest_and_bundle(self):
        package = self.manifest["package"]
        self.assertTrue((self.bundle / package["entrypoint"]).is_file())
        self.assertTrue((self.bundle / "licenses/modern-nju-thesis-MIT.txt").is_file())
        self.assertTrue((self.bundle / "THIRD_PARTY.md").is_file())
        self.assertEqual(len(list((self.bundle / "src/assets").glob("*.svg"))), 3)
        for excluded in (".git", ".github", "scripts", "tests", "build", "docs", "out", "thumbnail.png"):
            self.assertFalse((self.bundle / excluded).exists(), excluded)
        self.assertEqual(
            tomllib.loads((self.bundle / "typst.toml").read_text()), self.manifest
        )

    def test_initialized_template(self):
        self.assertEqual(
            (self.project / "main.typ").read_text(),
            (ROOT / "template/main.typ").read_text(),
        )
        # The generated report needs no copied module or asset directories.
        self.assertFalse((self.project / "src").exists())
        self.compile(self.project / "main.typ", "initialized")

    def test_cli_inputs(self):
        self.compile(
            self.project / "main.typ", "inputs",
            "--input", "student-name=测试同学",
            "--input", "student-id=123456789",
            "--input", "report-date=测试日期",
        )
        source = self.work / "metadata.typ"
        source.write_text(
            (self.project / "main.typ").read_text()
            + '\n#metadata((name: student-name, id: student-id, date: report-date)) <inputs>\n'
        )
        data = json.loads(self.run_command(
            "typst", "query", "--input", "student-name=测试同学",
            "--input", "student-id=123456789", "--input", "report-date=测试日期",
            source, "<inputs>", "--field", "value", "--one",
        ))
        self.assertEqual(data, {"name": "测试同学", "id": "123456789", "date": "测试日期"})

    def test_default_options_and_empty_info(self):
        self.compile(ROOT / "tests/fixtures/defaults.typ", "defaults")

    def test_components_and_multipage_layout(self):
        source = ROOT / "tests/fixtures/components.typ"
        self.compile(source, "components")
        value = json.loads(self.run_command(
            "typst", "query", source, "<result>", "--field", "value", "--one",
        ))
        self.assertEqual(value, "components-ok")

    def test_source_import_and_manual(self):
        self.compile(ROOT / "docs/manual.typ", "manual", "--root", ROOT)

    def test_import_does_not_apply_styles(self):
        source = self.work / "import-only.typ"
        source.write_text(
            f'#import "{self.spec}": *\n'
            '#context {\n'
            '  assert.eq(text.size, 11pt)\n'
            '  assert.eq(heading.numbering, none)\n'
            '}\n'
            'This document keeps the default Typst styles.\n'
        )
        self.compile(source, "import-only")

    def test_standalone_title_block(self):
        source = self.work / "title.typ"
        source.write_text(
            f'#import "{self.spec}": nju-title-block\n'
            '#nju-title-block(title: "独立标题", info: ("姓名": "张三"))\n'
        )
        self.compile(source, "title")

    def test_package_destination_is_not_bundled(self):
        source = self.work / "source-copy"
        source.mkdir()
        for name in ("typst.toml", ".typstignore", "scripts", "src", "template"):
            item = ROOT / name
            if item.is_dir():
                shutil.copytree(item, source / name)
            else:
                shutil.copy2(item, source / name)
        destination = source / "custom-output"
        for _ in range(2):
            self.run_command("bash", source / "scripts/package", destination)
        package = self.manifest["package"]
        bundle = destination / package["name"] / package["version"]
        self.assertTrue((bundle / "src/lib.typ").is_file())
        self.assertFalse((bundle / "custom-output").exists())

    def test_uninstall_custom_registry(self):
        registry = self.work / "uninstall-registry"
        self.run_command("bash", ROOT / "scripts/package", registry)
        package = self.manifest["package"]
        target = registry / package["name"] / package["version"]
        self.assertTrue(target.is_dir())
        self.run_command("bash", ROOT / "scripts/uninstall", registry)
        self.assertFalse(target.exists())
        self.assertTrue(self.bundle.exists())


if __name__ == "__main__":
    unittest.main()
