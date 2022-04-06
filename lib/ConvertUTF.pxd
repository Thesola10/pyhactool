cdef extern from "ConvertUTF.h":
    ctypedef unsigned long UTF32
    ctypedef unsigned short UTF16
    ctypedef unsigned char UTF8
    ctypedef unsigned char Boolean
    ctypedef enum ConversionResult:
        conversionOK = 0
        sourceExhausted = 1
        targetExhausted = 2
        sourceIllegal = 3
    ctypedef enum ConversionFlags:
        strictConversion = 0
        lenientConversion = 1
    ConversionResult ConvertUTF8toUTF16(const UTF8** sourceStart, const UTF8* sourceEnd, UTF16** targetStart, UTF16* targetEnd, ConversionFlags flags)
    ConversionResult ConvertUTF16toUTF8(const UTF16** sourceStart, const UTF16* sourceEnd, UTF8** targetStart, UTF8* targetEnd, ConversionFlags flags)
    ConversionResult ConvertUTF8toUTF32(const UTF8** sourceStart, const UTF8* sourceEnd, UTF32** targetStart, UTF32* targetEnd, ConversionFlags flags)
    ConversionResult ConvertUTF32toUTF8(const UTF32** sourceStart, const UTF32* sourceEnd, UTF8** targetStart, UTF8* targetEnd, ConversionFlags flags)
    ConversionResult ConvertUTF16toUTF32(const UTF16** sourceStart, const UTF16* sourceEnd, UTF32** targetStart, UTF32* targetEnd, ConversionFlags flags)
    ConversionResult ConvertUTF32toUTF16(const UTF32** sourceStart, const UTF32* sourceEnd, UTF16** targetStart, UTF16* targetEnd, ConversionFlags flags)
    Boolean isLegalUTF8Sequence(const UTF8* source, const UTF8* sourceEnd)


