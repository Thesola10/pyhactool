cdef extern from "sha.h":
    ctypedef enum hash_type_t:
        HASH_TYPE_SHA1 = 0
        HASH_TYPE_SHA256 = 1
    ctypedef struct sha_ctx_t:
        int digest
    sha_ctx_t* new_sha_ctx(hash_type_t type, int hmac)
    void sha_update(sha_ctx_t* ctx, const void* data, int l)
    void sha_get_hash(sha_ctx_t* ctx, unsigned char* hash)
    void free_sha_ctx(sha_ctx_t* ctx)
    void sha256_hash_buffer(unsigned char* digest, const void* data, int l)
    void sha256_get_buffer_hmac(void* digest, const void* secret, int s_l, const void* data, int d_l)


