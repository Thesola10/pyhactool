project(pyhactool)

find_package(Python3 COMPONENTS Interpreter Development REQUIRED)

include(UseCython)

add_subdirectory(_hactool)
