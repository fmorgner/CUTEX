# pylint: disable=missing-docstring
from conans import ConanFile


class CUTEXConan(ConanFile):
    name = 'CUTEX'
    version = '1.0.1'
    description = (
        'CUTEX is a set of extensions for the CUTE unit testing framework'
    )
    settings = None
    options = {
        'test': [True, False],
    }
    default_options = (
        'test=True',
    )
    exports_sources = (
        'CMakeLists.txt',
        'LICENSE',
        'README.md',
        'cmake/*',
        'include/*',
        'test/*',
    )
    url = 'https://github.com/fmorgner/CUTEX.git'
    license = 'LGPL 3'

    def build(self):
        cutex_test = '-DCUTEX_ENABLE_TESTS=%s' % (
            'On' if self.options.test
            else 'Off'
        )

        cutex_prefix = '-DCMAKE_INSTALL_PREFIX="%s"' % (
            self.package_folder
        )

        self.run(('cmake {directory}'
                  ' -DCUTEX_DEPS_VIA=conan'
                  ' {prefix}'
                  ' {test}').format(**{
                      'directory': self.conanfile_directory,
                      'prefix': cutex_prefix,
                      'test': cutex_test,
                  }))

        self.run('cmake --build . --target install')

    def package_info(self):
        self.cpp_info.includedirs = [
            'include'
        ]

    def requirements(self):
        self.requires('CUTE/[>=2.0]@fmorgner/stable')
