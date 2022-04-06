#  PXDGEN IMPORTS
from libc.stdint cimport uint8_t
from libc.stdint cimport uint32_t
from libc.stdint cimport uint64_t

cdef extern from "bktr.h":
    ctypedef struct bktr_header_t:
        uint64_t offset
        uint64_t size
        uint32_t magic
        uint32_t _0x14
        uint32_t num_entries
        uint32_t _0x1C
    ctypedef struct bktr_relocation_entry_t:
        uint64_t virt_offset
        uint64_t phys_offset
        uint32_t is_patch
    ctypedef struct bktr_relocation_bucket_t:
        uint32_t _0x0
        uint32_t num_entries
        uint64_t virtual_offset_end
        bktr_relocation_entry_t entries[818]
        uint8_t padding[8]
    ctypedef struct bktr_relocation_block_t:
        uint32_t _0x0
        uint32_t num_buckets
        uint64_t total_size
        uint64_t bucket_virtual_offsets[2046]
    ctypedef struct bktr_subsection_entry_t:
        uint64_t offset
        uint32_t _0x8
        uint32_t ctr_val
    ctypedef struct bktr_subsection_bucket_t:
        uint32_t _0x0
        uint32_t num_entries
        uint64_t physical_offset_end
        bktr_subsection_entry_t entries[1023]
    ctypedef struct bktr_subsection_block_t:
        uint32_t _0x0
        uint32_t num_buckets
        uint64_t total_size
        uint64_t bucket_physical_offsets[2046]
    bktr_relocation_bucket_t* bktr_get_relocation_bucket(bktr_relocation_block_t* block, uint32_t i)
    bktr_relocation_entry_t* bktr_get_relocation(bktr_relocation_block_t* block, uint64_t offset)
    bktr_subsection_bucket_t* bktr_get_subsection_bucket(bktr_subsection_block_t* block, uint32_t i)
    bktr_subsection_entry_t* bktr_get_subsection(bktr_subsection_block_t* block, uint64_t offset)


