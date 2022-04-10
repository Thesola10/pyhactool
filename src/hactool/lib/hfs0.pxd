#  PXDGEN IMPORTS
from .filepath cimport filepath_t
from libc.stdio cimport FILE
from libc.stdint cimport uint8_t
from libc.stdint cimport uint64_t
from .settings cimport hactool_ctx_t
from libc.stdint cimport uint32_t

cdef extern from "hfs0.h":
    ctypedef struct hfs0_header_t:
        uint32_t magic
        uint32_t num_files
        uint32_t string_table_size
        uint32_t reserved
    ctypedef struct hfs0_file_entry_t:
        uint64_t offset
        uint64_t size
        uint32_t string_table_offset
        uint32_t hashed_size
        uint64_t reserved
        unsigned char hash[32]
    ctypedef struct hfs0_ctx_t:
        FILE* file
        uint64_t offset
        uint64_t size
        hactool_ctx_t* tool_ctx
        hfs0_header_t* header
        const char* name
        const uint8_t* hash_suffix
    hfs0_file_entry_t* hfs0_get_file_entry(hfs0_header_t* hdr, uint32_t i)
    char* hfs0_get_string_table(hfs0_header_t* hdr)
    uint64_t hfs0_get_header_size(hfs0_header_t* hdr)
    char* hfs0_get_file_name(hfs0_header_t* hdr, uint32_t i)
    void hfs0_process(hfs0_ctx_t* ctx)
    void hfs0_save(hfs0_ctx_t* ctx)
    void hfs0_print(hfs0_ctx_t* ctx)
    void hfs0_save_file(hfs0_ctx_t* ctx, uint32_t i, filepath_t* dirpath)


