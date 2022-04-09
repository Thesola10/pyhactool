cmake_minimum_required(VERSION 3.10)
project(pyhactool)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_LIST_DIR}/cmake)

add_compile_options(-fPIC)

add_subdirectory(hactool/mbedtls)

include_directories(hactool hactool/mbedtls/include)

add_library(hactool STATIC  hactool/aes.c
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

target_link_libraries(hactool mbedtls mbedx509 mbedcrypto)

add_subdirectory(src)
