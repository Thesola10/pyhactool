import os
import platform

try:
    from setuptools import Extension
    from setuptools import setup
except:
    from distutils.core import Extension
    from distutils.core import setup
from distutils.command.build_ext import build_ext
from distutils import errors
from distutils import dep_util
from distutils import log


CURR_DIR = os.path.abspath(os.path.dirname(os.path.realpath(__file__)))

def get_version():
    """ Return HACTOOL_VERSION string as defined in hactool/version.h """
    version_file_path = os.path.join(CURR_DIR, 'hactool', 'version.h')
    version = ""
    with open (version_file_path, 'r') as f:
        for line in f:
            m = re.match(r'#define\sHACTOOL_VERSION\s"(.+)"', line)
            if m:
                version = m.group(1)
    return version


class BuildExt(build_ext):

    def get_source_files(self):
        filenames = build_ext.get_source_files(self)
        return filenames

    def build_extension(self, ext):
        if ext.sources is None or not isinstance(ext.sources, (list, tuple)):
            raise errors.DistutilsSetupError(
                "in 'ext_modules' option (extension '%s'), "
                "'sources' must be present and must be "
                "a list of source filenames" % ext.name)

        ext_path = self.get_ext_fullpath(ext.name)
        depends = ext.sources + ext.depends
        if not (self.force or dep_util.newer_group(depends, ext_path, 'newer')):
            log.debug("skipping '%s' extension (up-to-date)", ext.name)
            return
        else:
            log.info("building '%s' extension", ext.name)

        c_sources = []
        cxx_sources = []
        for source in ext.sources:
            if source.endswith('.c'):
                c_sources.append(source)
            else:
                cxx_sources.append(source)
        extra_args = ext.extra_compile_args or []

        objects = []
        for lang, sources in (('c', c_sources), ('c++', cxx_sources)):
            if lang == 'c++':
                if self.compiler.compiler_type == 'msvc':
                    extra_args.append('/EHsc')

            macros = ext.define_macros[:]
            if platform.system() == 'Darwin':
                macros.append(('OS_MACOSX', '1'))
            elif self.compiler.compiler_type == 'mingw32':
                # On Windows Python 2.7, pyconfig.h defines "hypot" as "_hypot",
                # This clashes with GCC's cmath, and causes compilation errors when
                # building under MinGW: http://bugs.python.org/issue11566
                macros.append(('_hypot', 'hypot'))
            for undef in ext.undef_macros:
                macros.append((undef,))

            objs = self.compiler.compile(
                sources,
                output_dir=self.build_temp,
                macros=macros,
                include_dirs=ext.include_dirs,
                debug=self.debug,
                extra_postargs=extra_args,
                depends=ext.depends)
            objects.extend(objs)

        self._built_objects = objects[:]
        if ext.extra_objects:
            objects.extend(ext.extra_objects)
        extra_args = ext.extra_link_args or []
        # when using GCC on Windows, we statically link libgcc and libstdc++,
        # so that we don't need to package extra DLLs
        if self.compiler.compiler_type == 'mingw32':
            extra_args.extend(['-static-libgcc', '-static-libstdc++'])

        ext_path = self.get_ext_fullpath(ext.name)
        # Detect target language, if not provided
        language = ext.language or self.compiler.detect_language(sources)

        self.compiler.link_shared_object(
            objects,
            ext_path,
            libraries=self.get_libraries(ext),
            library_dirs=ext.library_dirs,
            runtime_library_dirs=ext.runtime_library_dirs,
            extra_postargs=extra_args,
            export_symbols=self.get_export_symbols(ext),
            debug=self.debug,
            build_temp=self.build_temp,
            target_lang=language)


NAME = 'pyhactool'

VERSION = get_version()

URL = 'https://github.com/Thesola10/pyhactool'

DESCRIPTION = 'Python bindings for the hactool utility'

AUTHOR = 'Karim Vergnes <me@thesola.io>'

LICENSE = 'ISC'

PLATFORMS = ['Posix', 'MacOS X', 'Windows']

CLASSIFIERS = [
    'Development Status :: 2 - Pre-Alpha',
    'Environment :: Console',
    'Intended Audience :: Developers',
    'Operating System :: MacOS :: MacOS X',
    'Operating System :: Microsoft :: Windows',
    'Operating System :: POSIX :: Linux',
    'Programming Language :: C',
    'Programming Language :: Python',
    'Programming Language :: Python :: 3',
    'Topic :: Software Development :: Libraries',
    'Topic :: Software Development :: Libraries :: Python Modules',
    'Topic :: Utilities',
]

PY_MODULES = ['hactool']

EXT_MODULES = [
    Extension(
        '_hactool',
        sources = [
            '_hactool.c',
            'hactool/aes.c',
            'hactool/bktr.c',
            'hactool/cJSON.c',
            'hactool/ConvertUTF.c',
            'hactool/extkeys.c',
            'hactool/filepath.c',
            'hactool/hfs0.c',
            'hactool/kip.c',
            'hactool/lz4.c',
            'hactool/nax0.c',
        ],
        depends = [
            'hactool/aes.h',
            'hactool/bktr.h',
            'hactool/cJSON.h',
            'hactool/ConvertUTF.h',
            'hactool/extkeys.h',
            'hactool/filepath.h',
            'hactool/hfs0.h',
            'hactool/ivfc.h',
            'hactool/kip.h',
            'hactool/lz4.h',
            'hactool/nax0.h',
        ],
        include_dirs = [
            'hactool/mbedtls/include',
        ],
        language = 'c')
    ]

CMD_CLASS = {
    'build_ext': BuildExt
}

setup(
    name=NAME,
    description=DESCRIPTION,
    version=VERSION,
    url=URL,
    author=AUTHOR,
    license=LICENSE,
    platforms=PLATFORMS,
    classifiers=CLASSIFIERS,
    py_modules=PY_MODULES,
    ext_modules=EXT_MODULES,
    cmdclass=CMD_CLASS)
