#  PXDGEN IMPORTS
from libc.stdint cimport uint32_t
from libc.stdio cimport FILE
from .types cimport validity_t
from .kip cimport ini1_ctx_t
from libc.stdint cimport uint16_t
from libc.stdint cimport uint8_t
from .settings cimport hactool_ctx_t

cdef extern from "packages.h":
    ctypedef struct pk11_mariko_oem_header_t:
        unsigned char aes_mac[16]
        unsigned char rsa_sig[256]
        unsigned char salt[32]
        unsigned char hash[32]
        uint32_t bl_version
        uint32_t bl_size
        uint32_t bl_load_addr
        uint32_t bl_entrypoint
        unsigned char _0x160[16]
    ctypedef struct pk11_metadata_t:
        uint32_t ldr_hash
        uint32_t sm_hash
        uint32_t bl_hash
        uint32_t _0xC
        char build_date[14]
        unsigned char _0x1E
        unsigned char version
    ctypedef struct pk11_legacy_stage1_t:
        unsigned char stage1[16320]
        uint32_t pk11_size
        unsigned char _0x3FC4[12]
        unsigned char ctr[16]
    ctypedef struct pk11_modern_stage1_t:
        unsigned char stage1[28608]
        uint32_t pk11_size
        unsigned char _0x6FC4[12]
        unsigned char iv[16]
    ctypedef union pk11_stage1_t:
        pk11_legacy_stage1_t legacy
        pk11_modern_stage1_t modern
    ctypedef struct pk11_t:
        uint32_t magic
        uint32_t wb_size
        uint32_t wb_ep
        uint32_t _0xC
        uint32_t bl_size
        uint32_t bl_ep
        uint32_t sm_size
        uint32_t sm_ep
    ctypedef struct pk11_ctx_t:
        FILE* file
        hactool_ctx_t* tool_ctx
        int is_modern
        int is_mariko
        int is_decrypted
        unsigned int key_rev
        pk11_mariko_oem_header_t mariko_oem_header
        pk11_metadata_t metadata
        pk11_stage1_t stage1
        uint32_t pk11_size
        uint8_t* mariko_bl
        pk11_t* pk11
        unsigned char pk11_mac[16]
    ctypedef enum pk11_section_id_t:
        PK11_SECTION_BL = 0
        PK11_SECTION_SM = 1
        PK11_SECTION_WB = 2
    int pk11_get_section_idx(pk11_ctx_t* ctx, pk11_section_id_t section_id)
    pk11_section_id_t pk11_get_section_id(pk11_ctx_t* ctx, int id)
    uint32_t pk11_get_section_size(pk11_ctx_t* ctx, pk11_section_id_t section_id)
    uint32_t pk11_get_section_ofs(pk11_ctx_t* ctx, pk11_section_id_t section_id)
    unsigned char* pk11_get_section(pk11_ctx_t* ctx, pk11_section_id_t section_id)
    unsigned char* pk11_get_warmboot_bin(pk11_ctx_t* ctx)
    unsigned char* pk11_get_secmon(pk11_ctx_t* ctx)
    unsigned char* pk11_get_nx_bootloader(pk11_ctx_t* ctx)
    unsigned int pk11_get_warmboot_bin_size(pk11_ctx_t* ctx)
    unsigned int pk11_get_secmon_size(pk11_ctx_t* ctx)
    unsigned int pk11_get_nx_bootloader_size(pk11_ctx_t* ctx)
    void pk11_process(pk11_ctx_t* ctx)
    void pk11_print(pk11_ctx_t* ctx)
    void pk11_save(pk11_ctx_t* ctx)
    ctypedef struct pk21_header_t:
        unsigned char signature[256]
        unsigned char section_ctrs[4][16]
        uint32_t magic
        uint32_t base_offset
        uint32_t _0x58
        uint8_t version_max
        uint8_t version_min
        uint16_t _0x5E
        uint32_t section_sizes[4]
        uint32_t section_offsets[4]
        unsigned char section_hashes[4][32]
    ctypedef struct kernel_map_t:
        uint32_t text_start_offset
        uint32_t text_end_offset
        uint32_t rodata_start_offset
        uint32_t rodata_end_offset
        uint32_t data_start_offset
        uint32_t data_end_offset
        uint32_t bss_start_offset
        uint32_t bss_end_offset
        uint32_t ini1_start_offset
        uint32_t dynamic_offset
        uint32_t init_array_start_offset
        uint32_t init_array_end_offset
    ctypedef struct pk21_ctx_t:
        FILE* file
        hactool_ctx_t* tool_ctx
        unsigned int key_rev
        uint32_t package_size
        validity_t signature_validity
        validity_t section_validities[4]
        unsigned char* sections
        pk21_header_t header
        ini1_ctx_t ini1_ctx
        kernel_map_t* kernel_map
    void pk21_process(pk21_ctx_t* ctx)
    void pk21_print(pk21_ctx_t* ctx)
    void pk21_save(pk21_ctx_t* ctx)


