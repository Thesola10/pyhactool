#  PXDGEN IMPORTS
from .aes cimport aes_ctx_t
from libc.stdio cimport FILE
from libc.stdint cimport uint8_t
from libc.stdint cimport uint64_t
from .filepath cimport filepath_t
from .settings cimport hactool_ctx_t
from libc.stdint cimport uint32_t

cdef extern from "nax0.h":
    ctypedef struct nax0_header_t:
        uint8_t hmac_header[32]
        uint32_t magic
        uint32_t _0x24
        uint8_t keys[2][16]
        uint64_t size
        uint8_t _0x50[48]
    ctypedef struct nax0_ctx_t:
        filepath_t base_path
        hactool_ctx_t* tool_ctx
        aes_ctx_t* aes_ctx
        FILE** files
        unsigned int num_files
        unsigned int k
        unsigned char encrypted_keys[2][16]
        nax0_header_t header
    void nax0_process(nax0_ctx_t* ctx)
    void nax0_save(nax0_ctx_t* ctx)
    void nax0_print(nax0_ctx_t* ctx)


