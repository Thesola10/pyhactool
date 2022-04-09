#  PXDGEN IMPORTS
from .filepath cimport filepath_t
from libc.stdint cimport uint32_t
from libc.stdio cimport FILE

cdef extern from "settings.h":
    ctypedef enum keyset_variant_t:
        KEYSET_DEV = 0
        KEYSET_RETAIL = 1
    ctypedef enum hactool_basefile_t:
        BASEFILE_ROMFS = 0
        BASEFILE_NCA = 1
        BASEFILE_FAKE = 2
    ctypedef struct nca_keyset_t:
        unsigned char secure_boot_key[16]
        unsigned char tsec_key[16]
        unsigned char device_key[16]
        unsigned char keyblob_keys[32][16]
        unsigned char keyblob_mac_keys[32][16]
        unsigned char encrypted_keyblobs[32][176]
        unsigned char mariko_aes_class_keys[12][16]
        unsigned char mariko_kek[16]
        unsigned char mariko_bek[16]
        unsigned char keyblobs[32][144]
        unsigned char keyblob_key_sources[32][16]
        unsigned char keyblob_mac_key_source[16]
        unsigned char tsec_root_kek[16]
        unsigned char package1_mac_kek[16]
        unsigned char package1_kek[16]
        unsigned char tsec_auth_signatures[32][16]
        unsigned char tsec_root_keys[32][16]
        unsigned char master_kek_sources[32][16]
        unsigned char mariko_master_kek_sources[32][16]
        unsigned char master_keks[32][16]
        unsigned char master_key_source[16]
        unsigned char master_keys[32][16]
        unsigned char package1_mac_keys[32][16]
        unsigned char package1_keys[32][16]
        unsigned char package2_keys[32][16]
        unsigned char package2_key_source[16]
        unsigned char per_console_key_source[16]
        unsigned char aes_kek_generation_source[16]
        unsigned char aes_key_generation_source[16]
        unsigned char key_area_key_application_source[16]
        unsigned char key_area_key_ocean_source[16]
        unsigned char key_area_key_system_source[16]
        unsigned char titlekek_source[16]
        unsigned char header_kek_source[16]
        unsigned char sd_card_kek_source[16]
        unsigned char sd_card_key_sources[2][32]
        unsigned char save_mac_kek_source[16]
        unsigned char save_mac_key_source[16]
        unsigned char header_key_source[32]
        unsigned char header_key[32]
        unsigned char titlekeks[32][16]
        unsigned char key_area_keys[32][3][16]
        unsigned char xci_header_key[16]
        unsigned char save_mac_key[16]
        unsigned char sd_card_keys[2][32]
        unsigned char nca_hdr_fixed_key_moduli[2][256]
        unsigned char acid_fixed_key_moduli[2][256]
        unsigned char package2_fixed_key_modulus[256]
    ctypedef struct override_filepath_t:
        int enabled
        filepath_t path
    ctypedef struct titlekey_entry_t:
        unsigned char rights_id[16]
        unsigned char titlekey[16]
        unsigned char dec_titlekey[16]
    ctypedef struct known_titlekeys_t:
        unsigned int count
        titlekey_entry_t* titlekeys
    ctypedef struct hactool_settings_t:
        nca_keyset_t keyset
        int skip_key_warnings
        int has_expected_content_type
        unsigned int expected_content_type
        int append_section_types
        int suppress_keydata_output
        int has_cli_titlekey
        unsigned char cli_titlekey[16]
        unsigned char dec_cli_titlekey[16]
        known_titlekeys_t known_titlekeys
        int has_cli_contentkey
        unsigned char cli_contentkey[16]
        int has_sdseed
        unsigned char sdseed[16]
        unsigned char keygen_sbk[16]
        unsigned char keygen_tsec[16]
        filepath_t section_paths[4]
        filepath_t section_dir_paths[4]
        override_filepath_t exefs_path
        override_filepath_t exefs_dir_path
        override_filepath_t romfs_path
        override_filepath_t romfs_dir_path
        override_filepath_t out_dir_path
        filepath_t pfs0_dir_path
        filepath_t hfs0_dir_path
        filepath_t pk11_dir_path
        filepath_t pk21_dir_path
        filepath_t ini1_dir_path
        filepath_t plaintext_path
        filepath_t uncompressed_path
        filepath_t rootpt_dir_path
        filepath_t update_dir_path
        filepath_t normal_dir_path
        filepath_t secure_dir_path
        filepath_t logo_dir_path
        filepath_t header_path
        filepath_t nax0_path
        filepath_t nax0_sd_path
        filepath_t npdm_json_path
    enum hactool_file_type:
        FILETYPE_NCA = 0
        FILETYPE_PFS0 = 1
        FILETYPE_ROMFS = 2
        FILETYPE_NCA0_ROMFS = 3
        FILETYPE_HFS0 = 4
        FILETYPE_XCI = 5
        FILETYPE_NPDM = 6
        FILETYPE_PACKAGE1 = 7
        FILETYPE_PACKAGE2 = 8
        FILETYPE_INI1 = 9
        FILETYPE_KIP1 = 10
        FILETYPE_NSO0 = 11
        FILETYPE_NAX0 = 12
        FILETYPE_BOOT0 = 13
        FILETYPE_SAVE = 14
    struct nca_ctx:
        pass
    ctypedef struct hactool_ctx_t:
        hactool_file_type file_type
        FILE* file
        FILE* base_file
        hactool_basefile_t base_file_type
        nca_ctx* base_nca_ctx
        hactool_settings_t settings
        uint32_t action


