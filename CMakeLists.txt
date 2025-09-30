cmake_minimum_required(VERSION 3.20.2)

project(YAJL-Fort Fortran C)

set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake/")

find_package(YAJL REQUIRED)
if("${YAJL_VERSION}" VERSION_LESS "2.0.1")
  message(FATAL_ERROR "ERROR! version 2.0.1 or later of the yajl library is required")
endif()

# CMake build options
option(BUILD_HTML "Build HTML documentation (requires Sphinx)" OFF)
option(BUILD_SHARED_LIBS "Build shared object library" ON)
option(ENABLE_STD_MOD_PROC_NAME "Build with -assume std_mod_proc_name when using Intel" OFF)

if(NOT CMAKE_BUILD_TYPE)
  message(STATUS "Setting build type to 'Release' as none was specified")
  set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Choose the type of build" FORCE)
endif()

# Set missing CMake defaults for the NAG Fortran compiler
if(CMAKE_Fortran_COMPILER_ID STREQUAL NAG)
  set(CMAKE_Fortran_FLAGS_DEBUG "-u -O0 -gline -C -nan")
  set(CMAKE_Fortran_FLAGS_RELEASE "-u -O3")
  set(CMAKE_Fortran_FLAGS_RELWITHDEBINFO "${CMAKE_Fortran_FLAGS_RELEASE} -g")
endif()

# Disable assertions in release builds
add_compile_definitions($<$<CONFIG:Release,RelWithDebInfo>:NDEBUG>)

# Required compiler options
add_compile_options($<$<COMPILE_LANG_AND_ID:Fortran,NAG>:-f2018>)
add_compile_options($<$<COMPILE_LANG_AND_ID:Fortran,GNU>:-ffree-line-length-none>)
add_compile_options("$<$<COMPILE_LANG_AND_ID:Fortran,Intel,IntelLLVM>:-standard-semantics>"
  "$<$<AND:$<NOT:$<BOOL:${ENABLE_STD_MOD_PROC_NAME}>>,$<COMPILE_LANG_AND_ID:Fortran,Intel,IntelLLVM>>:SHELL:-assume nostd_mod_proc_name>")

# RPATH handling for installed shared libraries and dynamically-linked
# executables. See http://www.cmake.org/Wiki/CMake_RPATH_handling
set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_PREFIX}/lib")
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)

add_subdirectory(src)

option(BUILD_TESTS "Build test programs" ON)
if(BUILD_TESTS)
  enable_testing()
  add_subdirectory(test)
endif()

option(BUILD_HTML "Build HTML documentation (requires Sphinx)" OFF)
if(BUILD_HTML)
  find_package(Sphinx REQUIRED)
  add_subdirectory(doc/sphinx)
endif()
