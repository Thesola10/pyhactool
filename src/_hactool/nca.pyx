# cython: language_level=3

from .lib.nca       cimport nca_ctx_t, nca_init
from libc.stdlib    cimport malloc, free

from io import IOBase

cdef class NCAContext:
    cdef nca_ctx_t *_ctx

    def __cinit__(self, file: IOBase):
        self._ctx = <nca_ctx_t *>malloc(sizeof(nca_ctx_t))
        nca_init(self._ctx)

    def __dealloc__(self):
        free(self._ctx)
