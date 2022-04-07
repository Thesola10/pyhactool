#!/usr/bin/env python3

import os
import re

from setuptools import Extension
from setuptools import setup

from cmake_setup import CMakeExtension, CMakeBuildExt


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

setup(
    name="pyhactool",
    description="Python bindings for SciresM's pyhactool utility.",
    version=get_version(),
    url="https://github.com/Thesola10/pyhactool",
    author="Karim Vergnes",
    author_email="me@thesola.io",
    license='ISC',
    platforms=['Posix', 'MacOS X', 'Windows'],
    classifiers=CLASSIFIERS,
    package_dir={'': '.'},
    ext_modules=[
        CMakeExtension('hactool')
    ],
    cmdclass={
        'build_ext': CMakeBuildExt
    })
