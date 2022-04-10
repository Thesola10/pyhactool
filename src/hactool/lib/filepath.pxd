#  PXDGEN IMPORTS
from libc.stdint cimport uint16_t
from libc.stdint cimport uint32_t

from .types cimport validity_t
from .utils cimport filepath

cdef extern from "filepath.h":
    ctypedef uint16_t utf16char_t
    ctypedef char oschar_t
    struct filepath:
        char char_path[1023]
        oschar_t os_path[1023]
        validity_t valid
    ctypedef filepath filepath_t
    void os_strcpy(oschar_t* dst, const char* src)
    int os_makedir(const oschar_t* dir)
    int os_rmdir(const oschar_t* dir)
    void filepath_init(filepath_t* fpath)
    void filepath_copy(filepath_t* fpath, filepath_t* copy)
    void filepath_append(filepath_t* fpath, const char* format)
    void filepath_append_n(filepath_t* fpath, uint32_t n, const char* format)
    void filepath_set(filepath_t* fpath, const char* path)
    void filepath_set_format(filepath_t* fpath, const char* format)
    oschar_t* filepath_get(filepath_t* fpath)


