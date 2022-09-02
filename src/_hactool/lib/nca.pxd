#  PXDGEN IMPORTS
from .npdm cimport npdm_t
from .aes cimport aes_ctx_t
from .bktr cimport bktr_header_t
from libc.stdio cimport FILE
from .types cimport validity_t
from .ivfc cimport romfs_fentry_t
from .ivfc cimport romfs_direntry_t
from .bktr cimport bktr_relocation_block_t
from libc.stdint cimport uint64_t
from libc.stdint cimport uint8_t
from .bktr cimport bktr_subsection_block_t
from .ivfc cimport romfs_hdr_t
from .ivfc cimport ivfc_hdr_t
from .ivfc cimport ivfc_level_ctx_t
from .filepath cimport filepath_t
from .settings cimport hactool_ctx_t
from libc.stdint cimport uint32_t

cdef extern from "nca.h":
    ctypedef struct nca_section_entry_t:
        uint32_t media_start_offset
        uint32_t media_end_offset
        uint8_t _0x8[8]
    ctypedef struct bktr_superblock_t:
        ivfc_hdr_t ivfc_header
        uint8_t _0xE0[24]
        bktr_header_t relocation_header
        bktr_header_t subsection_header
    ctypedef struct bktr_section_ctx_t:
        bktr_superblock_t* superblock
        FILE* file
        validity_t superblock_hash_validity
        bktr_relocation_block_t* relocation_block
        bktr_subsection_block_t* subsection_block
        ivfc_level_ctx_t ivfc_levels[6]
        uint64_t romfs_offset
        romfs_hdr_t header
        romfs_direntry_t* directories
        romfs_fentry_t* files
        uint64_t virtual_seek
        uint64_t bktr_seek
        uint64_t base_seek
    ctypedef enum section_partition_type_t:
        PARTITION_ROMFS = 0
        PARTITION_PFS0 = 1
    ctypedef enum section_fs_type_t:
        FS_TYPE_PFS0 = 2
        FS_TYPE_ROMFS = 3
    ctypedef enum section_crypt_type_t:
        CRYPT_NONE = 1
        CRYPT_XTS = 2
        CRYPT_CTR = 3
        CRYPT_BKTR = 4
        CRYPT_NCA0 = 809583438
    ctypedef struct nca_fs_header_t:
        uint8_t _0x0
        uint8_t _0x1
        uint8_t partition_type
        uint8_t fs_type
        uint8_t crypt_type
        uint8_t _0x5[3]
        uint8_t _0x148[184]
    ctypedef struct nca_header_t:
        uint8_t fixed_key_sig[256]
        uint8_t npdm_key_sig[256]
        uint32_t magic
        uint8_t distribution
        uint8_t content_type
        uint8_t crypto_type
        uint8_t kaek_ind
        uint64_t nca_size
        uint64_t title_id
        uint8_t _0x218[4]
        uint8_t crypto_type2
        uint8_t fixed_key_generation
        uint8_t _0x222[14]
        uint8_t rights_id[16]
        nca_section_entry_t section_entries[4]
        uint8_t section_hashes[4][32]
        uint8_t encrypted_keys[4][16]
        uint8_t _0x340[192]
        nca_fs_header_t fs_headers[4]
    enum nca_section_type:
        PFS0 = 0
        ROMFS = 1
        BKTR = 2
        NCA0_ROMFS = 3
        INVALID = 4
    enum nca_version:
        NCAVERSION_UNKNOWN = 0
        NCAVERSION_NCA0_BETA = 1
        NCAVERSION_NCA0 = 2
        NCAVERSION_NCA2 = 3
        NCAVERSION_NCA3 = 4
    enum nca_content_type:
        NCACONTENTTYPE_PROGRAM = 0
        NCACONTENTTYPE_META = 1
        NCACONTENTTYPE_CONTROL = 2
        NCACONTENTTYPE_MANUAL = 3
        NCACONTENTTYPE_DATA = 4
        NCACONTENTTPYE_PUBLICDATA = 5
    ctypedef struct nca_section_ctx_t:
        int is_present
        nca_section_type type
        FILE* file
        uint64_t offset
        uint64_t size
        uint32_t section_num
        nca_fs_header_t* header
        int is_decrypted
        uint64_t sector_size
        uint64_t sector_mask
        aes_ctx_t* aes
        hactool_ctx_t* tool_ctx
        validity_t superblock_hash_validity
        unsigned char ctr[16]
        uint64_t cur_seek
        int sector_num
        uint32_t sector_ofs
        int physical_reads
        section_crypt_type_t crypt_type
    ctypedef struct nca_ctx_t:
        FILE* file
        int file_size
        unsigned char crypto_type
        int has_rights_id
        int is_decrypted
        int is_cli_target
        nca_version format_version
        validity_t fixed_sig_validity
        validity_t npdm_sig_validity
        hactool_ctx_t* tool_ctx
        unsigned char decrypted_keys[4][16]
        unsigned char title_key[16]
        nca_section_ctx_t section_contexts[4]
        npdm_t* npdm
        nca_header_t header
    void nca_init(nca_ctx_t* ctx)
    void nca_process(nca_ctx_t* ctx)
    int nca_decrypt_header(nca_ctx_t* ctx)
    void nca_decrypt_key_area(nca_ctx_t* ctx)
    void nca_print(nca_ctx_t* ctx)
    void nca_free_section_contexts(nca_ctx_t* ctx)
    void nca_section_fseek(nca_section_ctx_t* ctx, uint64_t offset)
    int nca_section_fread()
    void nca_save_section_file(nca_section_ctx_t* ctx, uint64_t ofs, uint64_t total_size, filepath_t* filepath)
    void nca_process_pfs0_section(nca_section_ctx_t* ctx)
    void nca_process_ivfc_section(nca_section_ctx_t* ctx)
    void nca_process_nca0_romfs_section(nca_section_ctx_t* ctx)
    void nca_process_bktr_section(nca_section_ctx_t* ctx)
    void nca_print_pfs0_section(nca_section_ctx_t* ctx)
    void nca_print_ivfc_section(nca_section_ctx_t* ctx)
    void nca_print_nca0_romfs_section(nca_section_ctx_t* ctx)
    void nca_print_bktr_section(nca_section_ctx_t* ctx)
    void nca_save_section(nca_section_ctx_t* ctx)
    void nca_save_pfs0_section(nca_section_ctx_t* ctx)
    void nca_save_ivfc_section(nca_section_ctx_t* ctx)
    void nca_save_nca0_romfs_section(nca_section_ctx_t* ctx)
    void nca_save_bktr_section(nca_section_ctx_t* ctx)


