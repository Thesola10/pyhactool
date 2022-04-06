#  PXDGEN IMPORTS
from libc.stdint cimport uint32_t
from libc.stdio cimport FILE
from .types cimport validity_t
from libc.stdint cimport uint64_t
from libc.stdint cimport uint8_t
from .settings cimport hactool_ctx_t

cdef extern from "nso.h":
    ctypedef struct nso0_segment_t:
        uint32_t file_off
        uint32_t dst_off
        uint32_t decomp_size
        uint32_t align_or_total_size
    ctypedef struct nso0_header_t:
        uint32_t magic
        uint32_t _0x4
        uint32_t _0x8
        uint32_t flags
        nso0_segment_t segments[3]
        uint8_t build_id[32]
        uint32_t compressed_sizes[3]
        uint8_t _0x6C[36]
        uint64_t dynstr_extents
        uint64_t dynsym_extents
        uint8_t section_hashes[3][32]
    ctypedef struct nso0_ctx_t:
        FILE* file
        hactool_ctx_t* tool_ctx
        nso0_header_t* header
        nso0_header_t* uncompressed_header
        validity_t segment_validities[3]
    void nso0_process(nso0_ctx_t* ctx)
    void nso0_print(nso0_ctx_t* ctx)
    void nso0_save(nso0_ctx_t* ctx)
    uint64_t nso_get_section_size(nso0_header_t* header, unsigned int segment)
    uint64_t nso_get_size(nso0_header_t* header)


