project(pyhactool)

include(UseCython)

if (CMAKE_HOST_WIN32)
    add_definitions(-DMS_WIN64)
endif (CMAKE_HOST_WIN32)

add_subdirectory(hactool)

install(TARGETS hactool
        EXCLUDE_FROM_ALL
        COMPONENT python_modules
        DESTINATION .)
