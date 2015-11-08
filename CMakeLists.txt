cmake_minimum_required(VERSION 2.8)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/Modules/")

project(yajlfort C Fortran)

find_package(YAJL REQUIRED)
if("${YAJL_VERSION_STRING}" VERSION_LESS "2.0.1")
  message(FATAL_ERROR "ERROR! version 2.0.1 or later of the yajl library is required")
endif()
set(LIBS ${LIBS} ${YAJL_LIBRARIES})

option(ENABLE_EXAMPLES "Build example programs" OFF)

option(ENABLE_JSON "Build experimental json module and tests" OFF)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()

message(STATUS "CMAKE_Fortran_COMPILER_ID=${CMAKE_Fortran_COMPILER_ID}")
if (CMAKE_Fortran_COMPILER_ID STREQUAL "NAG")
  set (CMAKE_Fortran_FLAGS_RELEASE "-O3 -w=uda -DNDEBUG")
  set (CMAKE_Fortran_FLAGS_DEBUG   "-g90")
elseif (CMAKE_Fortran_COMPILER_ID STREQUAL "Intel")
  set (CMAKE_Fortran_FLAGS_RELEASE "-O3 -DNDEBUG -assume realloc_lhs")
  set (CMAKE_Fortran_FLAGS_DEBUG   "-g -assume realloc_lhs")
  message(STATUS "${CMAKE_Fortran_COMPILER_VERSION}")
  # Extract the Intel compiler version
  execute_process(COMMAND ${CMAKE_Fortran_COMPILER} --version OUTPUT_VARIABLE CMAKE_Fortran_COMPILER_VERSION)
  string(REGEX MATCH "[0-9]+.[0-9]+.[0-9]+" CMAKE_Fortran_COMPILER_VERSION ${CMAKE_Fortran_COMPILER_VERSION})
  if (${CMAKE_Fortran_COMPILER_VERSION} VERSION_LESS "13.0.1")
    message(FATAL_ERROR "ERROR: Intel Fortran 13.0.1 or later is required; your version is ${CMAKE_Fortran_COMPILER_VERSION}")
  endif()
endif()

# Fortran preprocessor defines
set(Fortran_COMPILE_DEFINITIONS)
if(CMAKE_Fortran_COMPILER_ID MATCHES Intel)
  list(APPEND Fortran_COMPILE_DEFINITIONS NO_2008_LHS_POLY_REALLOC)
elseif(CMAKE_Fortran_COMPILER_ID MATCHES NAG)
  # NAG 6.0 actually supports this feature, but not able to get version yet
  list(APPEND Fortran_COMPILE_DEFINITIONS NO_2008_LHS_POLY_REALLOC)
elseif(CMAKE_Fortran_COMPILER_ID MATCHES GNU)
  list(APPEND Fortran_COMPILE_DEFINITIONS NO_2008_LHS_POLY_REALLOC)
endif()

add_subdirectory(src)

if(ENABLE_EXAMPLES)
  add_subdirectory(examples)
endif()

if(ENABLE_JSON)
  add_subdirectory(test/json)
endif()
