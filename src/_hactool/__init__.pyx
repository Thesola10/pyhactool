# cython: language_level=3

__doc__ = """Native library containing hactool components."""

from .lib.settings  cimport hactool_ctx_t
from .lib.nca       cimport nca_ctx_t

from libc.stdlib    cimport malloc, free
from libc.stdio     cimport fdopen, fclose

from io     import IOBase

include "nca.pyx"

cpdef enum hactool_basefile_t:
    BASEFILE_ROMFS
    BASEFILE_NCA
    BASEFILE_FAKE

cpdef enum hactool_file_type:
    FILETYPE_NCA
    FILETYPE_PFS0
    FILETYPE_ROMFS
    FILETYPE_NCA0_ROMFS
    FILETYPE_HFS0
    FILETYPE_XCI
    FILETYPE_NPDM
    FILETYPE_PACKAGE1
    FILETYPE_PACKAGE2
    FILETYPE_INI1
    FILETYPE_KIP1
    FILETYPE_NSO0
    FILETYPE_NAX0
    FILETYPE_BOOT0
    FILETYPE_SAVE

cdef class HactoolContext:
    """Wrapper class for the hactool_ctx_t extractor context data"""
    cdef hactool_ctx_t *_ctx

    def __cinit__(self  , file: IOBase
                        , filetype: hactool_file_type
                        , basefile: IOBase
                        , basetype: hactool_basefile_t
                        , ncacontext: NCAContext|None
                        ):
        self._ctx = <hactool_ctx_t *>malloc(sizeof(hactool_ctx_t))
        self._ctx.file = fdopen(file.fileno(), "r")
        self._ctx.file_type = filetype
        self._ctx.base_file = fdopen(basefile.fileno(), "r")
        self._ctx.base_file_type = basetype
        if ncacontext is not None:
            self._ctx.base_nca_ctx = <nca_ctx_t *>ncacontext._ctx
        else:
            self._ctx.base_nca_ctx = <nca_ctx_t *>NULL

    def __dealloc__(self):
        fclose(self._ctx.file)
        fclose(self._ctx.base_file)
        free(self._ctx)
