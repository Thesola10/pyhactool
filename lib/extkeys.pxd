#  PXDGEN IMPORTS
from libc.stdio cimport FILE
from .settings cimport titlekey_entry_t
from .settings cimport hactool_settings_t

cdef extern from "extkeys.h":
    void parse_hex_key(unsigned char* key, const char* hex, unsigned int len)
    void extkeys_initialize_settings(hactool_settings_t* settings, FILE* f)
    void extkeys_parse_titlekeys(hactool_settings_t* settings, FILE* f)
    int settings_has_titlekey(hactool_settings_t* settings, const unsigned char* rights_id)
    void settings_add_titlekey(hactool_settings_t* settings, const unsigned char* rights_id, const unsigned char* titlekey)
    titlekey_entry_t* settings_get_titlekey(hactool_settings_t* settings, const unsigned char* rights_id)


