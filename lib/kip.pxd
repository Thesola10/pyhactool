#  PXDGEN IMPORTS
from libc.stdio cimport FILE
from libc.stdint cimport uint8_t
from libc.stdint cimport uint64_t
from .settings cimport hactool_ctx_t
from libc.stdint cimport uint32_t

cdef extern from "kip.h":
    ctypedef struct ini1_header_t:
        uint32_t magic
        uint32_t size
        uint32_t num_processes
        uint32_t _0xC
    ctypedef struct kip_section_header_t:
        uint32_t out_offset
        uint32_t out_size
        uint32_t compressed_size
        uint32_t attribute
    ctypedef struct kip1_header_t:
        uint32_t magic
        char name[12]
        uint64_t title_id
        uint32_t process_category
        uint8_t main_thread_priority
        uint8_t default_core
        uint8_t _0x1E
        uint8_t flags
        kip_section_header_t section_headers[6]
        uint32_t capabilities[32]
    ctypedef struct kip1_ctx_t:
        FILE* file
        hactool_ctx_t* tool_ctx
        kip1_header_t* header
    ctypedef struct ini1_ctx_t:
        FILE* file
        hactool_ctx_t* tool_ctx
        ini1_header_t* header
        kip1_ctx_t kips[80]
    void ini1_process(ini1_ctx_t* ctx)
    void ini1_print(ini1_ctx_t* ctx)
    void ini1_save(ini1_ctx_t* ctx)
    char* kip1_get_json(kip1_ctx_t* ctx)
    void kip1_process(kip1_ctx_t* ctx)
    void kip1_print(kip1_ctx_t* ctx, int suppress)
    void kip1_save(kip1_ctx_t* ctx)
    uint64_t kip1_get_size(kip1_ctx_t* ctx)
    uint64_t kip1_get_size_from_header(kip1_header_t* header)


