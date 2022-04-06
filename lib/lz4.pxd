#  PXDGEN IMPORTS
from libc.stdint cimport uint16_t
from libc.stdint cimport uint8_t
from libc.stdint cimport uint32_t

cdef extern from "lz4.h":
    int LZ4_versionNumber()
    const char* LZ4_versionString()
    int LZ4_compress_default(const char* src, char* dst, int srcSize, int dstCapacity)
    int LZ4_decompress_safe(const char* src, char* dst, int compressedSize, int dstCapacity)
    int LZ4_compressBound(int inputSize)
    int LZ4_compress_fast(const char* src, char* dst, int srcSize, int dstCapacity, int acceleration)
    int LZ4_sizeofState()
    int LZ4_compress_fast_extState(void* state, const char* src, char* dst, int srcSize, int dstCapacity, int acceleration)
    int LZ4_compress_destSize(const char* src, char* dst, int* srcSizePtr, int targetDstSize)
    int LZ4_decompress_fast(const char* src, char* dst, int originalSize)
    int LZ4_decompress_safe_partial(const char* src, char* dst, int srcSize, int targetOutputSize, int dstCapacity)
    ctypedef LZ4_stream_u LZ4_stream_t
    LZ4_stream_t* LZ4_createStream()
    int LZ4_freeStream(LZ4_stream_t* streamPtr)
    void LZ4_resetStream(LZ4_stream_t* streamPtr)
    int LZ4_loadDict(LZ4_stream_t* streamPtr, const char* dictionary, int dictSize)
    int LZ4_compress_fast_continue(LZ4_stream_t* streamPtr, const char* src, char* dst, int srcSize, int dstCapacity, int acceleration)
    int LZ4_saveDict(LZ4_stream_t* streamPtr, char* safeBuffer, int maxDictSize)
    ctypedef LZ4_streamDecode_u LZ4_streamDecode_t
    LZ4_streamDecode_t* LZ4_createStreamDecode()
    int LZ4_freeStreamDecode(LZ4_streamDecode_t* LZ4_stream)
    int LZ4_setStreamDecode(LZ4_streamDecode_t* LZ4_streamDecode, const char* dictionary, int dictSize)
    int LZ4_decompress_safe_continue(LZ4_streamDecode_t* LZ4_streamDecode, const char* src, char* dst, int srcSize, int dstCapacity)
    int LZ4_decompress_fast_continue(LZ4_streamDecode_t* LZ4_streamDecode, const char* src, char* dst, int originalSize)
    int LZ4_decompress_safe_usingDict(const char* src, char* dst, int srcSize, int dstCapcity, const char* dictStart, int dictSize)
    int LZ4_decompress_fast_usingDict(const char* src, char* dst, int originalSize, const char* dictStart, int dictSize)
    struct LZ4_stream_t_internal:
        pass
    ctypedef LZ4_stream_t_internal LZ4_stream_t_internal
    struct LZ4_stream_t_internal:
        uint32_t hashTable[4096]
        uint32_t currentOffset
        uint16_t initCheck
        uint16_t tableType
        const uint8_t* dictionary
        const LZ4_stream_t_internal* dictCtx
        uint32_t dictSize
    ctypedef struct LZ4_streamDecode_t_internal:
        const uint8_t* externalDict
        int extDictSize
        const uint8_t* prefixEnd
        int prefixSize
    int LZ4_compress(const char* source, char* dest, int sourceSize)
    int LZ4_compress_limitedOutput(const char* source, char* dest, int sourceSize, int maxOutputSize)
    int LZ4_compress_withState(void* state, const char* source, char* dest, int inputSize)
    int LZ4_compress_limitedOutput_withState(void* state, const char* source, char* dest, int inputSize, int maxOutputSize)
    int LZ4_compress_continue(LZ4_stream_t* LZ4_streamPtr, const char* source, char* dest, int inputSize)
    int LZ4_compress_limitedOutput_continue(LZ4_stream_t* LZ4_streamPtr, const char* source, char* dest, int inputSize, int maxOutputSize)
    int LZ4_uncompress(const char* source, char* dest, int outputSize)
    int LZ4_uncompress_unknownOutputSize(const char* source, char* dest, int isize, int maxOutputSize)
    void* LZ4_create(char* inputBuffer)
    int LZ4_sizeofStreamState()
    int LZ4_resetStreamState(void* state, char* inputBuffer)
    char* LZ4_slideInputBuffer(void* state)
    int LZ4_decompress_safe_withPrefix64k(const char* src, char* dst, int compressedSize, int maxDstSize)
    int LZ4_decompress_fast_withPrefix64k(const char* src, char* dst, int originalSize)


