#  PXDGEN IMPORTS
from .hfs0 cimport hfs0_ctx_t
from .settings cimport hactool_ctx_t
from libc.stdint cimport uint32_t
from libc.stdio cimport FILE
from .types cimport validity_t
from libc.stdint cimport uint8_t
from libc.stdint cimport uint64_t

cdef extern from "xci.h":
    ctypedef enum cartridge_type_t:
        CARTSIZE_1GB = 250
        CARTSIZE_2GB = 248
        CARTSIZE_4GB = 240
        CARTSIZE_8GB = 224
        CARTSIZE_16GB = 225
        CARTSIZE_32GB = 226
    ctypedef enum gamecard_firmware_version_t:
        GC_FIRMWARE_DEVELOPMENT = 0
        GC_FIRMWARE_RETAIL_100 = 1
        GC_FIRMWARE_RETAIL_400 = 2
    ctypedef enum gamecard_access_control_t:
        GC_ACCESS_CONTROL_25MHZ = 10551313
        GC_ACCESS_CONTROL_50MHZ = 10551312
    ctypedef enum xci_region_compatibility_t:
        COMPAT_GLOBAL = 0
        COMPAT_CHINA = 1
    ctypedef struct xci_gamecard_info_t:
        uint64_t firmware_version
        uint32_t access_control
        uint32_t read_time_wait_1
        uint32_t read_time_wait_2
        uint32_t write_time_wait_1
        uint32_t write_time_wait_2
        uint32_t firmware_mode
        uint32_t cup_version
        uint8_t compatibility_type
        uint8_t _0x25
        uint8_t _0x26
        uint8_t _0x27
        unsigned char update_partition_hash[8]
        uint64_t cup_title_id
    ctypedef struct xci_header_t:
        uint8_t header_sig[256]
        uint32_t magic
        uint32_t secure_offset
        uint32_t _0x108
        uint8_t _0x10C
        uint8_t cart_type
        uint8_t _0x10E
        uint8_t _0x10F
        uint64_t _0x110
        uint64_t cart_size
        unsigned char reversed_iv[16]
        uint64_t hfs0_offset
        uint64_t hfs0_header_size
        unsigned char hfs0_header_hash[32]
        unsigned char crypto_header_hash[32]
        uint32_t _0x180
        uint32_t _0x184
        uint32_t _0x188
        uint32_t _0x18C
        unsigned char encrypted_data[112]
    ctypedef struct xci_ctx_t:
        FILE* file
        validity_t header_sig_validity
        validity_t cert_sig_validity
        validity_t hfs0_hash_validity
        hfs0_ctx_t partition_ctx
        hfs0_ctx_t normal_ctx
        hfs0_ctx_t update_ctx
        hfs0_ctx_t secure_ctx
        hfs0_ctx_t logo_ctx
        hactool_ctx_t* tool_ctx
        unsigned char iv[16]
        int has_decrypted_header
        unsigned char decrypted_header[112]
        xci_header_t header
        int has_fake_compat_type
        uint8_t fake_compat_type
    void xci_process(xci_ctx_t* ctx)
    void xci_save(xci_ctx_t* ctx)
    void xci_print(xci_ctx_t* ctx)


