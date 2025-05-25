cmake_minimum_required(VERSION 3.18)
project(forunittest LANGUAGES Fortran)

# Project metadata
set(PROJECT_VERSION "0.1.0")
set(PROJECT_AUTHOR "Seyed Ali Ghasemi")
set(PROJECT_MAINTAINER "info@gha3mi.com")
set(PROJECT_LICENSE "BSD-3-Clause")

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

# Main source files
file(GLOB_RECURSE SOURCES src/*.f90)
add_library(forunittest ${SOURCES})
target_include_directories(forunittest PUBLIC ${CMAKE_Fortran_MODULE_DIRECTORY})
target_link_libraries(forunittest PUBLIC FACE)

# Example: demo
add_executable(demo example/demo.f90)
target_link_libraries(demo PRIVATE forunittest)

# Test: test
enable_testing()
add_executable(test_exec test/test.f90)
set_target_properties(test_exec PROPERTIES OUTPUT_NAME "test")
target_link_libraries(test_exec PRIVATE forunittest)
add_test(NAME forunittest_test COMMAND test)