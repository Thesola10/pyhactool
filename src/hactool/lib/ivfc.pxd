#  PXDGEN IMPORTS
from libc.stdio cimport FILE
from .types cimport validity_t
from libc.stdint cimport uint8_t
from libc.stdint cimport uint64_t
from .settings cimport hactool_ctx_t
from libc.stdint cimport uint32_t

cdef extern from "ivfc.h":
    ctypedef struct ivfc_level_hdr_t:
        uint64_t logical_offset
        uint64_t hash_data_size
        uint32_t block_size
        uint32_t reserved
    ctypedef struct ivfc_level_ctx_t:
        uint64_t data_offset
        uint64_t data_size
        uint64_t hash_offset
        uint32_t hash_block_size
        validity_t hash_validity
    ctypedef struct ivfc_hdr_t:
        uint32_t magic
        uint32_t id
        uint32_t master_hash_size
        uint32_t num_levels
        ivfc_level_hdr_t level_headers[6]
        uint8_t _0xA0[32]
        uint8_t master_hash[32]
    ctypedef struct ivfc_save_hdr_t:
        uint32_t magic
        uint32_t id
        uint32_t master_hash_size
        uint32_t num_levels
        ivfc_level_hdr_t level_headers[6]
        uint8_t salt_source[32]
    ctypedef struct romfs_hdr_t:
        uint64_t header_size
        uint64_t dir_hash_table_offset
        uint64_t dir_hash_table_size
        uint64_t dir_meta_table_offset
        uint64_t dir_meta_table_size
        uint64_t file_hash_table_offset
        uint64_t file_hash_table_size
        uint64_t file_meta_table_offset
        uint64_t file_meta_table_size
        uint64_t data_offset
    ctypedef struct romfs_direntry_t:
        uint32_t parent
        uint32_t sibling
        uint32_t child
        uint32_t file
        uint32_t hash
        uint32_t name_size
    ctypedef struct romfs_fentry_t:
        uint32_t parent
        uint32_t sibling
        uint64_t offset
        uint64_t size
        uint32_t hash
        uint32_t name_size
    ctypedef struct romfs_superblock_t:
        ivfc_hdr_t ivfc_header
        uint8_t _0xE0[88]
    ctypedef struct romfs_ctx_t:
        romfs_superblock_t* superblock
        FILE* file
        hactool_ctx_t* tool_ctx
        validity_t superblock_hash_validity
        ivfc_level_ctx_t ivfc_levels[6]
        uint64_t romfs_offset
        romfs_hdr_t header
        romfs_direntry_t* directories
        romfs_fentry_t* files
    romfs_direntry_t* romfs_get_direntry(romfs_direntry_t* directories, uint32_t offset)
    romfs_fentry_t* romfs_get_fentry(romfs_fentry_t* files, uint32_t offset)
    void romfs_process(romfs_ctx_t* ctx)
    void romfs_save(romfs_ctx_t* ctx)
    void romfs_print(romfs_ctx_t* ctx)


