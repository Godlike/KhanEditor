# Copyright (C) 2017 by Godlike
# This code is licensed under the MIT license (MIT)
# (http://opensource.org/licenses/MIT)

cmake_minimum_required(VERSION 3.1)
project(KhanEditor)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/godlike")
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/third_party")

option(KHAN_BUILD_DOCUMENTATION "Build documentation" OFF)
option(KHAN_BUILD_TESTS "Build tests" OFF)
set(KHAN_ROOT "${CMAKE_CURRENT_SOURCE_DIR}" CACHE STRING "Khan root directory.")

#Report status
message(STATUS "${PROJECT_NAME} configuration:")
message(STATUS "-- KHAN_BUILD_TESTS: ${KHAN_BUILD_TESTS}")
message(STATUS "-- KHAN_BUID_DOCUMENTATION: ${KHAN_BUID_DOCUMENTATION}")

#UNICORN
include(UnicornConfig)
add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/godlike/Unicorn)
include_directories(${UNICORN_RENDER_INCLUDE_DIRS})

#IMGUI
include(ImguiConfig)
include_directories(${IMGUI_INCLUDE_DIR})

#Target
include(KhanConfig)
# Setup output folders if none were specified
if (NOT CMAKE_ARCHIVE_OUTPUT_DIRECTORY)
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/output/lib)
endif()

if (NOT CMAKE_LIBRARY_OUTPUT_DIRECTORY)
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/output/lib)
endif()

if (NOT CMAKE_RUNTIME_OUTPUT_DIRECTORY)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/output)
endif()

include_directories (
    ${KHAN_INCLUDE_DIR}
    ${GLFW_INCLUDE_DIR}
)
set(KHAN_HEADERS
	Khan/include/Khan.hpp
    Khan/include/imgui_impl_glfw_vulkan.h
)
set(KHAN_SOURCES
	Khan/source/Khan.cpp
    Khan/source/imgui_impl_glfw_vulkan.cpp
    Khan/source/Main.cpp
)

add_executable (${PROJECT_NAME}
    ${KHAN_SOURCES}
    ${KHAN_HEADERS}
    ${IMGUI_SOURCES}
)
target_link_libraries(${PROJECT_NAME}
    ${UNICORN_LIB}
    ${GLFW_LIB}
    ${VULKAN_LIBRARY}
)

#Tests
if (KHAN_BUILD_TESTS)
    enable_testing()
    set(CATCH_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/third_party/Catch2)
    add_subdirectory(test)
endif()
