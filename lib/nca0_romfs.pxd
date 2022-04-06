#  PXDGEN IMPORTS
from libc.stdint cimport uint32_t
from libc.stdio cimport FILE
from .types cimport validity_t
from .ivfc cimport romfs_fentry_t
from .ivfc cimport romfs_direntry_t
from libc.stdint cimport uint64_t
from libc.stdint cimport uint8_t
from .settings cimport hactool_ctx_t

cdef extern from "nca0_romfs.h":
    ctypedef struct nca0_romfs_hdr_t:
        uint32_t header_size
        uint32_t dir_hash_table_offset
        uint32_t dir_hash_table_size
        uint32_t dir_meta_table_offset
        uint32_t dir_meta_table_size
        uint32_t file_hash_table_offset
        uint32_t file_hash_table_size
        uint32_t file_meta_table_offset
        uint32_t file_meta_table_size
        uint32_t data_offset
    ctypedef struct nca0_romfs_superblock_t:
        uint8_t master_hash[32]
        uint32_t block_size
        uint32_t always_2
        uint64_t hash_table_offset
        uint64_t hash_table_size
        uint64_t romfs_offset
        uint64_t romfs_size
        uint8_t _0x48[240]
    ctypedef struct nca0_romfs_ctx_t:
        nca0_romfs_superblock_t* superblock
        FILE* file
        hactool_ctx_t* tool_ctx
        validity_t superblock_hash_validity
        validity_t hash_table_validity
        uint64_t romfs_offset
        nca0_romfs_hdr_t header
        romfs_direntry_t* directories
        romfs_fentry_t* files
    void nca0_romfs_process(nca0_romfs_ctx_t* ctx)
    void nca0_romfs_save(nca0_romfs_ctx_t* ctx)
    void nca0_romfs_print(nca0_romfs_ctx_t* ctx)


