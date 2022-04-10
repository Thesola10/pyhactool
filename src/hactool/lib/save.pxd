#  PXDGEN IMPORTS
from .settings cimport hactool_ctx_t
from libc.stdint cimport uint32_t
from libc.stdio cimport FILE
from .types cimport validity_t
from .ivfc cimport ivfc_save_hdr_t
from libc.stdint cimport uint64_t
from libc.stdint cimport uint8_t

cdef extern from "save.h":
    struct save_ctx_t:
        pass
    ctypedef save_ctx_t save_ctx_t
    ctypedef struct fs_layout_t:
        uint32_t magic
        uint32_t version
        uint8_t hash[32]
        uint64_t file_map_entry_offset
        uint64_t file_map_entry_size
        uint64_t meta_map_entry_offset
        uint64_t meta_map_entry_size
        uint64_t file_map_data_offset
        uint64_t file_map_data_size
        uint64_t duplex_l1_offset_a
        uint64_t duplex_l1_offset_b
        uint64_t duplex_l1_size
        uint64_t duplex_data_offset_a
        uint64_t duplex_data_offset_b
        uint64_t duplex_data_size
        uint64_t journal_data_offset
        uint64_t journal_data_size_a
        uint64_t journal_data_size_b
        uint64_t journal_size
        uint64_t duplex_master_offset_a
        uint64_t duplex_master_offset_b
        uint64_t duplex_master_size
        uint64_t ivfc_master_hash_offset_a
        uint64_t ivfc_master_hash_offset_b
        uint64_t ivfc_master_hash_size
        uint64_t journal_map_table_offset
        uint64_t journal_map_table_size
        uint64_t journal_physical_bitmap_offset
        uint64_t journal_physical_bitmap_size
        uint64_t journal_virtual_bitmap_offset
        uint64_t journal_virtual_bitmap_size
        uint64_t journal_free_bitmap_offset
        uint64_t journal_free_bitmap_size
        uint64_t ivfc_l1_offset
        uint64_t ivfc_l1_size
        uint64_t ivfc_l2_offset
        uint64_t ivfc_l2_size
        uint64_t ivfc_l3_offset
        uint64_t ivfc_l3_size
        uint64_t fat_offset
        uint64_t fat_size
        uint64_t duplex_index
        uint64_t fat_ivfc_master_hash_a
        uint64_t fat_ivfc_master_hash_b
        uint64_t fat_ivfc_l1_offset
        uint64_t fat_ivfc_l1_size
        uint64_t fat_ivfc_l2_offset
        uint64_t fat_ivfc_l2_size
        uint8_t _0x190[112]
    ctypedef struct duplex_info_t:
        uint64_t offset
        uint64_t length
        uint32_t block_size_power
    ctypedef struct duplex_header_t:
        uint32_t magic
        uint32_t version
        duplex_info_t layers[3]
    ctypedef struct journal_map_header_t:
        uint32_t version
        uint32_t main_data_block_count
        uint32_t journal_block_count
        uint32_t _0x0C
    ctypedef struct journal_header_t:
        uint32_t magic
        uint32_t version
        uint64_t total_size
        uint64_t journal_size
        uint64_t block_size
    ctypedef struct save_fs_header_t:
        uint32_t magic
        uint32_t version
        uint64_t block_count
        uint64_t block_size
    ctypedef struct fat_header_t:
        uint64_t block_size
        uint64_t allocation_table_offset
        uint32_t allocation_table_block_count
        uint32_t _0x14
        uint64_t data_offset
        uint32_t data_block_count
        uint32_t _0x24
        uint32_t directory_table_block
        uint32_t file_table_block
    ctypedef struct remap_header_t:
        uint32_t magic
        uint32_t version
        uint32_t map_entry_count
        uint32_t map_segment_count
        uint32_t segment_bits
        uint8_t _0x14[44]
    struct remap_segment_ctx_t:
        pass
    ctypedef remap_segment_ctx_t remap_segment_ctx_t
    struct remap_entry_ctx_t:
        pass
    ctypedef remap_entry_ctx_t remap_entry_ctx_t
    struct remap_entry_ctx_t:
        uint64_t virtual_offset
        uint64_t physical_offset
        uint64_t size
        uint32_t alignment
        uint32_t _0x1C
        uint64_t virtual_offset_end
        uint64_t physical_offset_end
        remap_segment_ctx_t* segment
        remap_entry_ctx_t* next
    struct remap_segment_ctx_t:
        uint64_t offset
        uint64_t length
        remap_entry_ctx_t** entries
        uint64_t entry_count
    ctypedef struct duplex_bitmap_t:
        uint8_t* data
        uint8_t* bitmap
    ctypedef struct duplex_storage_ctx_t:
        uint32_t block_size
        uint8_t* bitmap_storage
        uint8_t* data_a
        uint8_t* data_b
        duplex_bitmap_t bitmap
        uint64_t _length
    enum base_storage_type:
        STORAGE_BYTES = 0
        STORAGE_DUPLEX = 1
        STORAGE_REMAP = 2
        STORAGE_JOURNAL = 3
    ctypedef struct remap_storage_ctx_t:
        remap_header_t* header
        remap_entry_ctx_t* map_entries
        remap_segment_ctx_t* segments
        base_storage_type type
        uint64_t base_storage_offset
        duplex_storage_ctx_t* duplex
        FILE* file
    ctypedef struct extra_data_t:
        uint64_t title_id
        uint8_t user_id[16]
        uint64_t save_id
        uint8_t save_data_type
        uint8_t _0x21[31]
        uint64_t save_owner_id
        uint64_t timestamp
        uint64_t _0x50
        uint64_t data_size
        uint64_t journal_size
        uint64_t commit_id
    ctypedef struct save_header_t:
        uint8_t cmac[16]
        uint8_t _0x10[240]
        fs_layout_t layout
        duplex_header_t duplex_header
        ivfc_save_hdr_t data_ivfc_header
        uint32_t _0x404
        journal_header_t journal_header
        journal_map_header_t map_header
        uint8_t _0x438[464]
        save_fs_header_t save_header
        fat_header_t fat_header
        remap_header_t main_remap_header
        remap_header_t meta_remap_header
        uint64_t _0x6D0
        extra_data_t extra_data
        uint8_t _0x748[912]
        ivfc_save_hdr_t fat_ivfc_header
        uint8_t _0xB98[13416]
    ctypedef struct hierarchical_duplex_storage_ctx_t:
        duplex_storage_ctx_t layers[2]
        duplex_storage_ctx_t data_layer
        uint64_t _length
    ctypedef struct duplex_fs_layer_info_t:
        uint8_t* data_a
        uint8_t* data_b
        duplex_info_t info
    ctypedef struct journal_map_params_t:
        uint8_t* map_storage
        uint8_t* physical_block_bitmap
        uint8_t* virtual_block_bitmap
        uint8_t* free_block_bitmap
    ctypedef struct journal_map_entry_t:
        uint32_t physical_index
        uint32_t virtual_index
    ctypedef struct journal_map_ctx_t:
        journal_map_header_t* header
        journal_map_entry_t* entries
        uint8_t* map_storage
    ctypedef struct journal_storage_ctx_t:
        journal_map_ctx_t map
        journal_header_t* header
        uint32_t block_size
        uint64_t journal_data_offset
        uint64_t _length
        FILE* file
    ctypedef struct ivfc_level_save_ctx_t:
        uint64_t data_offset
        uint64_t data_size
        uint64_t hash_offset
        uint32_t hash_block_size
        validity_t hash_validity
        base_storage_type type
        save_ctx_t* save_ctx
    ctypedef struct integrity_verification_info_ctx_t:
        ivfc_level_save_ctx_t* data
        uint32_t block_size
        uint8_t salt[32]
    struct integrity_verification_storage_ctx_t:
        pass
    ctypedef integrity_verification_storage_ctx_t integrity_verification_storage_ctx_t
    struct integrity_verification_storage_ctx_t:
        ivfc_level_save_ctx_t* hash_storage
        ivfc_level_save_ctx_t* base_storage
        validity_t* block_validities
        uint8_t salt[32]
        uint32_t sector_size
        uint32_t sector_count
        uint64_t _length
        integrity_verification_storage_ctx_t* next_level
    ctypedef struct hierarchical_integrity_verification_storage_ctx_t:
        ivfc_level_save_ctx_t levels[5]
        ivfc_level_save_ctx_t* data_level
        validity_t** level_validities
        uint64_t _length
        integrity_verification_storage_ctx_t integrity_storages[4]
    ctypedef struct allocation_table_entry_t:
        uint32_t prev
        uint32_t next
    ctypedef struct allocation_table_ctx_t:
        uint32_t free_list_entry_index
        void* base_storage
        fat_header_t* header
    ctypedef struct allocation_table_storage_ctx_t:
        hierarchical_integrity_verification_storage_ctx_t* base_storage
        uint32_t block_size
        uint32_t initial_block
        allocation_table_ctx_t* fat
        uint64_t _length
    ctypedef struct allocation_table_iterator_ctx_t:
        allocation_table_ctx_t* fat
        uint32_t virtual_block
        uint32_t physical_block
        uint32_t current_segment_size
        uint32_t next_block
        uint32_t prev_block
    ctypedef struct save_entry_key_t:
        char name[64]
        uint32_t parent
    ctypedef struct save_file_info_t:
        uint32_t start_block
        uint64_t length
        uint32_t _0xC[2]
    ctypedef struct save_find_position_t:
        uint32_t next_directory
        uint32_t next_file
        uint32_t _0x8[3]
    ctypedef struct save_table_entry_t:
        uint32_t next_sibling
    ctypedef struct save_fs_list_entry_t:
        uint32_t parent
        char name[64]
        save_table_entry_t value
        uint32_t next
    ctypedef struct save_filesystem_list_ctx_t:
        uint32_t free_list_head_index
        uint32_t used_list_head_index
        allocation_table_storage_ctx_t storage
    ctypedef struct hierarchical_save_file_table_ctx_t:
        save_filesystem_list_ctx_t file_table
        save_filesystem_list_ctx_t directory_table
    ctypedef struct save_filesystem_ctx_t:
        hierarchical_integrity_verification_storage_ctx_t* base_storage
        allocation_table_ctx_t allocation_table
        save_fs_header_t* header
        hierarchical_save_file_table_ctx_t file_table
    struct save_ctx_t:
        FILE* file
        hactool_ctx_t* tool_ctx
        save_header_t header
        validity_t header_cmac_validity
        validity_t header_hash_validity
        uint8_t* data_ivfc_master
        uint8_t* fat_ivfc_master
        remap_storage_ctx_t data_remap_storage
        remap_storage_ctx_t meta_remap_storage
        duplex_fs_layer_info_t duplex_layers[3]
        hierarchical_duplex_storage_ctx_t duplex_storage
        journal_storage_ctx_t journal_storage
        journal_map_params_t journal_map_info
        hierarchical_integrity_verification_storage_ctx_t core_data_ivfc_storage
        hierarchical_integrity_verification_storage_ctx_t fat_ivfc_storage
        uint8_t* fat_storage
        save_filesystem_ctx_t save_filesystem_core
    uint32_t allocation_table_entry_index_to_block(uint32_t entry_index)
    uint32_t allocation_table_block_to_entry_index(uint32_t block_index)
    int allocation_table_is_list_end(allocation_table_entry_t* entry)
    int allocation_table_is_list_start(allocation_table_entry_t* entry)
    int allocation_table_get_next(allocation_table_entry_t* entry)
    int allocation_table_get_prev(allocation_table_entry_t* entry)
    allocation_table_entry_t* save_allocation_table_read_entry(allocation_table_ctx_t* ctx, uint32_t entry_index)
    uint32_t save_allocation_table_get_free_list_entry_index(allocation_table_ctx_t* ctx)
    uint32_t save_allocation_table_get_free_list_block_index(allocation_table_ctx_t* ctx)
    void save_process(save_ctx_t* ctx)
    void save_process_header(save_ctx_t* ctx)
    void save_save(save_ctx_t* ctx)
    void save_print(save_ctx_t* ctx)
    void save_free_contexts(save_ctx_t* ctx)


