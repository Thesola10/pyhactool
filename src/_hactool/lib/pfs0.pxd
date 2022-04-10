#  PXDGEN IMPORTS
from .npdm cimport npdm_t
from libc.stdint cimport uint32_t
from libc.stdio cimport FILE
from .types cimport validity_t
from libc.stdint cimport uint8_t
from libc.stdint cimport uint64_t
from .settings cimport hactool_ctx_t

cdef extern from "pfs0.h":
    ctypedef struct pfs0_header_t:
        uint32_t magic
        uint32_t num_files
        uint32_t string_table_size
        uint32_t reserved
    ctypedef struct pfs0_file_entry_t:
        uint64_t offset
        uint64_t size
        uint32_t string_table_offset
        uint32_t reserved
    ctypedef struct pfs0_superblock_t:
        uint8_t master_hash[32]
        uint32_t block_size
        uint32_t always_2
        uint64_t hash_table_offset
        uint64_t hash_table_size
        uint64_t pfs0_offset
        uint64_t pfs0_size
        uint8_t _0x48[240]
    ctypedef struct pfs0_ctx_t:
        pfs0_superblock_t* superblock
        FILE* file
        hactool_ctx_t* tool_ctx
        validity_t superblock_hash_validity
        validity_t hash_table_validity
        int is_exefs
        npdm_t* npdm
        pfs0_header_t* header
    pfs0_file_entry_t* pfs0_get_file_entry(pfs0_header_t* hdr, uint32_t i)
    char* pfs0_get_string_table(pfs0_header_t* hdr)
    uint64_t pfs0_get_header_size(pfs0_header_t* hdr)
    char* pfs0_get_file_name(pfs0_header_t* hdr, uint32_t i)
    void pfs0_process(pfs0_ctx_t* ctx)
    void pfs0_save(pfs0_ctx_t* ctx)
    void pfs0_print(pfs0_ctx_t* ctx)


