# cython: language_level=3

from .lib.nca       cimport nca_ctx_t, nca_init
from libc.stdlib    cimport malloc, free
from libc.stdio     cimport fdopen, fclose

from io import IOBase

import os

cdef class NCAContext:
    """Wrapper type for the NCA decryptor context data"""
    cdef nca_ctx_t *_ctx

    def __cinit__(self, file: IOBase):
        self._ctx = <nca_ctx_t *>malloc(sizeof(nca_ctx_t))
        nca_init(self._ctx)

        self._ctx.file = fdopen(file.fileno(), "r")
        file.seek(0, os.SEEK_END)
        self._ctx.file_size = file.tell()


    def __dealloc__(self):
        fclose(self._ctx.file)
        free(self._ctx)
