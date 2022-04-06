#  PXDGEN IMPORTS
from libc.stdint cimport uint32_t
from libc.stdio cimport FILE
from .types cimport validity_t
from libc.stdint cimport uint8_t
from libc.stdint cimport uint64_t

cdef extern from "utils.h":
    struct filepath:
        pass
    uint32_t align(uint32_t offset, uint32_t alignment)
    uint64_t align64(uint64_t offset, uint64_t alignment)
    void print_magic(const char* prefix, uint32_t magic)
    void memdump(FILE* f, const char* prefix, const void* data, int size)
    uint64_t _fsize(const char* filename)
    void save_file_section(FILE* f_in, uint64_t ofs, uint64_t total_size, filepath* filepath)
    void save_buffer_to_file(void* buf, uint64_t size, filepath* filepath)
    void save_buffer_to_directory_file(void* buf, uint64_t size, filepath* dirpath, const char* filename)
    const char* get_key_revision_summary(uint8_t key_rev)
    FILE* open_key_file(const char* prefix)
    validity_t check_memory_hash_table(FILE* f_in, unsigned char* hash_table, uint64_t data_ofs, uint64_t data_len, uint64_t block_size, int full_block)
    validity_t check_file_hash_table(FILE* f_in, uint64_t hash_ofs, uint64_t data_ofs, uint64_t data_len, uint64_t block_size, int full_block)
    validity_t check_memory_hash_table_with_suffix(FILE* f_in, unsigned char* hash_table, uint64_t data_ofs, uint64_t data_len, uint64_t block_size, const uint8_t* suffix, int full_block)
    uint64_t media_to_real(uint64_t media)


