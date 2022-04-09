cdef extern from "rsa.h":
    int rsa2048_pss_verify(const void* data, int len, const unsigned char* signature, const unsigned char* modulus)
    int rsa2048_pkcs1_verify(const void* data, int len, const unsigned char* signature, const unsigned char* modulus)
    int rsa2048_oaep_decrypt_verify(void* out, int max_out_len, const unsigned char* signature, const unsigned char* modulus, const unsigned char* exponent, int exponent_len, const unsigned char* label_hash, int* out_len)


