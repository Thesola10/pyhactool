#  PXDGEN IMPORTS
from .settings cimport keyset_variant_t
from .settings cimport nca_keyset_t

cdef extern from "pki.h":
    void pki_derive_keys(nca_keyset_t* keyset)
    void pki_print_keys(nca_keyset_t* keyset)
    void pki_initialize_keyset(nca_keyset_t* keyset, keyset_variant_t variant)
    const unsigned char* pki_get_beta_nca0_modulus()
    void pki_set_beta_nca0_exponent(void* exponent)
    const unsigned char* pki_get_beta_nca0_exponent()
    const unsigned char* pki_get_beta_nca0_label_hash()


