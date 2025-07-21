cmake_minimum_required(VERSION 3.18)
project(forunittest LANGUAGES Fortran)

# Project metadata
set(PROJECT_VERSION "0.1.0")
set(PROJECT_AUTHOR "Seyed Ali Ghasemi")
set(PROJECT_MAINTAINER "info@gha3mi.com")
set(PROJECT_LICENSE "BSD-3-Clause")

# Build options
option(FORUNITTEST_BUILD_EXAMPLES "Build forunittest examples" OFF)
option(FORUNITTEST_BUILD_TESTS "Build forunittest tests" ON)

# Fortran settings
enable_language(Fortran)
set(CMAKE_Fortran_MODULE_DIRECTORY ${CMAKE_BINARY_DIR}/mod)

# Dependency: FACE
include(FetchContent)
FetchContent_Declare(
  FACE
  GIT_REPOSITORY https://github.com/szaghi/FACE.git
)
FetchContent_MakeAvailable(FACE)

# source files (from src/*.f90)
file(GLOB_RECURSE SOURCES src/*.f90)
add_library(forunittest ${SOURCES})
target_include_directories(forunittest PUBLIC ${CMAKE_Fortran_MODULE_DIRECTORY})
target_link_libraries(forunittest PUBLIC FACE)

# Build examples (from example/*.f90)
if(FORUNITTEST_BUILD_EXAMPLES)
  file(GLOB EXAMPLES example/*.f90)
  foreach(example_file ${EXAMPLES})
    get_filename_component(example_name ${example_file} NAME_WE)
    add_executable(${example_name} ${example_file})
    target_link_libraries(${example_name} PRIVATE forunittest)
  endforeach()
endif()

# Build tests (from test/*.f90)
if(FORUNITTEST_BUILD_TESTS)
  enable_testing()
  file(GLOB TESTS test/*.f90)
  foreach(test_file ${TESTS})
    get_filename_component(test_name ${test_file} NAME_WE)
    add_executable(${test_name}_exec ${test_file})
    target_link_libraries(${test_name}_exec PRIVATE forunittest)
    add_test(NAME ${test_name} COMMAND ${test_name}_exec)
  endforeach()
endif()
