#!/usr/bin/env python3

import os
import re
import platform
import shutil

from setuptools import Extension
from setuptools import setup

from cmake_setup import CMakeExtension, CMakeBuildExt

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

PACKAGE_DIR = {'': '.'}

PY_MODULES = ['hactool']

EXT_MODULES = [
    CMakeExtension('_hactool')
]

CMD_CLASS = {
    'build_ext': CMakeBuildExt
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
    package_dir=PACKAGE_DIR,
    py_modules=PY_MODULES,
    ext_modules=EXT_MODULES,
    cmdclass=CMD_CLASS)
