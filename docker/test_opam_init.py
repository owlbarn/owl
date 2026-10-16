"""Exercise Dockerfile opam initialization without downloads or compiler builds.

Run with Python 3 and opam 2.3+ (which has the numbered shell setup menu).
"""

import os
from pathlib import Path
import re
import shlex
import subprocess
import tempfile
import unittest


class OpamInitTest(unittest.TestCase):
    def test_initialization_is_noninteractive(self):
        repo_root = Path(__file__).resolve().parents[1]
        dockerfiles = [repo_root / "Dockerfile", *sorted((repo_root / "docker").glob("Dockerfile.*"))]
        for dockerfile in dockerfiles:
            for command in re.findall(r"^RUN (.*\bopam init\b.*)$", dockerfile.read_text(), re.M):
                with self.subTest(dockerfile=str(dockerfile.relative_to(repo_root))):
                    # Keep the real input pipeline and init flags, but skip the
                    # compiler and subsequent environment setup for a fast test.
                    command = command.split("&&", 1)[0].strip()
                    command = re.sub(r"--comp\s+\$OCAML_VER", "--bare", command)
                    with tempfile.TemporaryDirectory(prefix="owl-opam-init-") as tmp:
                        path = Path(tmp)
                        repository = path / "repository"
                        repository.mkdir()
                        (repository / "repo").write_text('opam-version: "2.0"\n')
                        command += " " + shlex.join([
                            "--no-opamrc", f"--root={path / 'opam'}",
                            f"--dot-profile={path / 'profile'}", "local", str(repository),
                        ])
                        # Do not inherit a CI-wide OPAMYES that could hide the bug.
                        env = {k: v for k, v in os.environ.items() if not k.startswith("OPAM")}
                        with (path / "log").open("w+") as log:
                            result = subprocess.run(
                                ["timeout", "10", "sh", "-c", command], env=env,
                                stdin=subprocess.DEVNULL, stdout=log, stderr=log,
                            )
                            log.seek(0)
                            self.assertEqual(result.returncode, 0, log.read(2500))
                        self.assertTrue((path / "opam" / "config").is_file())
                        self.assertFalse((path / "profile").exists())


if __name__ == "__main__":
    unittest.main()
