cmake_minimum_required(VERSION 3.10)
project(pyhactool)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_LIST_DIR}/cmake)

add_compile_options(-fPIC)

set(ENABLE_PROGRAMS OFF)
set(ENABLE_TESTING OFF)
add_subdirectory(hactool/mbedtls)

include_directories(hactool hactool/mbedtls/include)

add_definitions(-D_BSD_SOURCE
                -D_POSIX_SOURCE
                -D_POSIX_C_SOURCE=200112L
                -D_DEFAULT_SOURCE
                -D__USE_MINGW_ANSI_STDIO=1
                -D_FILE_OFFSET_BITS=64)

add_library(hactool1 STATIC hactool/aes.c
                            hactool/bktr.c
                            hactool/cJSON.c
                            hactool/ConvertUTF.c
                            hactool/extkeys.c
                            hactool/filepath.c
                            hactool/hfs0.c
                            hactool/kip.c
                            hactool/lz4.c
                            hactool/nax0.c
                            hactool/nca.c
                            hactool/npdm.c
                            hactool/nso.c
                            hactool/pfs0.c
                            hactool/pki.c
                            hactool/romfs.c
                            hactool/rsa.c
                            hactool/save.c
                            hactool/sha.c
                            hactool/utils.c
                            hactool/xci.c)

target_link_libraries(hactool1 mbedtls mbedx509 mbedcrypto)

add_subdirectory(src)
