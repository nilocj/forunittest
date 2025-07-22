cmake_minimum_required(VERSION 3.18)

project(forunittest LANGUAGES Fortran)

# Project metadata
set(PROJECT_AUTHOR "Seyed Ali Ghasemi")
set(PROJECT_MAINTAINER "info@gha3mi.com")
set(PROJECT_LICENSE "BSD-3-Clause")

# Build options
option(FORUNITTEST_BUILD_EXAMPLES "Build forunittest examples" OFF)
option(FORUNITTEST_BUILD_TESTS "Build forunittest tests" OFF)

# Fortran settings
enable_language(Fortran)
set(CMAKE_Fortran_MODULE_DIRECTORY ${CMAKE_BINARY_DIR}/mod)

# Dependency: FACE
include(FetchContent)
FetchContent_Declare(
  FACE
  GIT_REPOSITORY https://github.com/szaghi/FACE.git
  GIT_TAG master
)
FetchContent_MakeAvailable(FACE)

# Source files
file(GLOB_RECURSE SOURCES CONFIGURE_DEPENDS
  src/*.f90
  src/*.F90
)

add_library(forunittest ${SOURCES})
set_target_properties(forunittest PROPERTIES
  Fortran_MODULE_DIRECTORY ${CMAKE_Fortran_MODULE_DIRECTORY}
)
target_link_libraries(forunittest PUBLIC FACE)
target_include_directories(forunittest PUBLIC ${CMAKE_Fortran_MODULE_DIRECTORY})

# Build examples
if(FORUNITTEST_BUILD_EXAMPLES)
  file(GLOB EXAMPLES CONFIGURE_DEPENDS
    example/*.f90
    example/*.F90
  )
  foreach(example_file ${EXAMPLES})
    get_filename_component(example_name ${example_file} NAME_WE)
    add_executable(${example_name} ${example_file})
    target_link_libraries(${example_name} PRIVATE forunittest)
  endforeach()
endif()

# Build tests
if(FORUNITTEST_BUILD_TESTS)
  enable_testing()
  file(GLOB TESTS CONFIGURE_DEPENDS
    test/*.f90
    test/*.F90
  )
  foreach(test_file ${TESTS})
    get_filename_component(test_name ${test_file} NAME_WE)
    add_executable(${test_name}_exec ${test_file})
    target_link_libraries(${test_name}_exec PRIVATE forunittest)
    add_test(NAME ${test_name} COMMAND ${test_name}_exec)
  endforeach()
endif()
