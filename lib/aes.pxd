cdef extern from "aes.h":
    ctypedef enum aes_mode_t:
        AES_MODE_ECB = 0
        AES_MODE_CTR = 1
        AES_MODE_XTS = 2
        AES_MODE_CBC = 3
    ctypedef enum aes_operation_t:
        AES_DECRYPT = 0
        AES_ENCRYPT = 1
    ctypedef struct aes_ctx_t:
        int cipher_enc
        int cipher_dec
    aes_ctx_t* new_aes_ctx(const void* key, unsigned int key_size, aes_mode_t mode)
    void free_aes_ctx(aes_ctx_t* ctx)
    void aes_setiv(aes_ctx_t* ctx, const void* iv, int l)
    void aes_encrypt(aes_ctx_t* ctx, void* dst, const void* src, int l)
    void aes_decrypt(aes_ctx_t* ctx, void* dst, const void* src, int l)
    void aes_calculate_cmac(void* dst, void* src, int size, const void* key)
    void aes_xts_encrypt(aes_ctx_t* ctx, void* dst, const void* src, int l, int sector, int sector_size)
    void aes_xts_decrypt(aes_ctx_t* ctx, void* dst, const void* src, int l, int sector, int sector_size)


