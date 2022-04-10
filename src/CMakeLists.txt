project(pyhactool)

include(UseCython)

add_subdirectory(_hactool)

install(TARGETS _hactool
        EXCLUDE_FROM_ALL
        COMPONENT python_modules
        DESTINATION .)
