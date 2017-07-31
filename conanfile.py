from conans import ConanFile


class CUTEXConan(ConanFile):
    name = 'CUTEX'
    version = '1.0.0'
    description = """CUTEX - CUTE eXtended"""
    url = 'https://github.com/fmorgner/CUTEX.git'
    license = 'LGPL 3'
    settings = None
    requires = 'CUTE/[>=2.0]@fmorgner/stable'

    sourceUrl = 'https://github.com/fmorgner/CUTEX.git'

    def source(self):
        self.run('git clone ' + self.sourceUrl)

    def build(self):
        pass

    def package(self):
        self.copy('*.h', src='CUTEX/include', dst='include')
