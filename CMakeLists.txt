cmake_minimum_required(VERSION 2.8)

project(yajlfort Fortran)

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
