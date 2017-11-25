# Copyright (C) 2017 by Godlike
# This code is licensed under the MIT license (MIT)
# (http://opensource.org/licenses/MIT)

set(KHAN_NAME "Khan" CACHE STRING "Khan project name.")

set(KHAN_VENDOR "Godlike")
set(KHAN_DESCRIPTION "Khan editor")
set(KHAN_COMMENT "")
set(KHAN_COPYRIGHT "Copyright (C) 2017 by Godlike")
set(KHAN_LEGAL_TM "Distributed under the MIT license (http://opensource.org/licenses/MIT)")

set(KHAN_VERSION_MAJOR 0)
set(KHAN_VERSION_MINOR 1)
set(KHAN_VERSION_PATCH 0)
set(KHAN_VERSION_TWEAK 0)

set(KHAN_VERSION "${KHAN_VERSION_MAJOR}.${KHAN_VERSION_MINOR}.${KHAN_VERSION_PATCH}")
set(KHAN_SOVERSION "${KHAN_VERSION_MAJOR}.${KHAN_VERSION_MINOR}")

if(NOT DEFINED KHAN_ROOT)
    set(KHAN_ROOT "${CMAKE_CURRENT_SOURCE_DIR}" CACHE STRING "Khan root directory.")
endif()

list(APPEND CMAKE_MODULE_PATH "${KHAN_ROOT}/Khan/cmake")

#Build flags
if (UNIX)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++14 -Wall -Werror -pedantic")
    set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -s -O3")
    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -g3 -ggdb3 -O0")
elseif(WIN32)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /std:c++14 /MP /W3")
    add_definitions(-D_CRT_SECURE_NO_WARNINGS)
endif()

set(KHAN_INCLUDE_DIR
    ${KHAN_ROOT}
    ${KHAN_ROOT}/Khan/include
    CACHE LIST "Khan include directories."
)
