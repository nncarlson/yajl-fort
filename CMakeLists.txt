cmake_minimum_required(VERSION 2.8)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/Modules/")

project(yajlfort Fortran)

find_package(YAJL REQUIRED)
if("${YAJL_VERSION_STRING}" VERSION_LESS "2.0.1")
  message(FATAL_ERROR "ERROR! version 2.0.1 or later of the yajl library is required")
endif()
set(LIBS ${LIBS} ${YAJL_LIBRARIES})

option(ENABLE_EXAMPLES "Build example programs" OFF)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()

message(STATUS "CMAKE_Fortran_COMPILER_ID=${CMAKE_Fortran_COMPILER_ID}")
if (CMAKE_Fortran_COMPILER_ID STREQUAL "NAG")
  set (CMAKE_Fortran_FLAGS_RELEASE "-O3 -w=uda -DNDEBUG")
  set (CMAKE_Fortran_FLAGS_DEBUG   "-g90")
elseif (CMAKE_Fortran_COMPILER_ID STREQUAL "Intel")
  set (CMAKE_Fortran_FLAGS_RELEASE "-O3 -DNDEBUG")
  set (CMAKE_Fortran_FLAGS_DEBUG   "-g")
endif()

add_subdirectory(src)

if(ENABLE_EXAMPLES)
  add_subdirectory(examples)
endif()
