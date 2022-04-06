cmake_minimum_required(VERSION 3.10)
project(pyhactool)

find_package(PythonInterp 3.5 REQUIRED)
find_package(PythonLibs 3.5 REQUIRED)

set(USE_STATIC_MBEDTLS_LIBRARY OFF)
set(USE_SHARED_MBEDTLS_LIBRARY ON)

add_subdirectory(hactool/mbedtls)

include_directories(hactool/mbedtls/include ${PYTHON_INCLUDE_DIR})

add_library(_hactool SHARED _hactool.c
                            hactool/aes.c
                            hactool/bktr.c
                            hactool/cJSON.c
                            hactool/ConvertUTF.c
                            hactool/extkeys.c
                            hactool/filepath.c
                            hactool/hfs0.c
                            hactool/kip.c
                            hactool/lz4.c
                            hactool/pfs0.c
                            hactool/pki.c
                            hactool/romfs.c
                            hactool/rsa.c
                            hactool/save.c
                            hactool/sha.c
                            hactool/utils.c
                            hactool/xci.c)

target_link_libraries(_hactool mbedtls mbedx509 mbedcrypto)

set_target_properties(
    _hactool
    PROPERTIES
        PREFIX ""
        OUTPUT_NAME "_hactool"
        LINKER_LANGUAGE C
    )
