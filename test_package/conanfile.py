# pylint: disable=missing-docstring
import os
from conans import ConanFile, CMake


class CuteTestConan(ConanFile):
    settings = (
        'compiler',
        'arch',
    )
    generators = "cmake"

    def build(self):
        cmake = CMake(self)
        cmake.configure(source_dir=self.conanfile_directory)
        cmake.build()

    def test(self):
        os.chdir("bin")
        self.run(".%spackage_test" % os.sep)
