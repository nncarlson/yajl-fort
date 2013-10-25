include_directories(${yajlfort_BINARY_DIR}/src/mod_files)
add_executable (yajl_fort_parse_example yajl_fort_parse_example.F90)
target_link_libraries(yajl_fort_parse_example yajl_fort)

### Enable workaround for Intel compiler bug
if(${CMAKE_Fortran_COMPILER_ID} MATCHES "Intel")
  if(${CMAKE_Fortran_COMPILER_VERSION} VERSION_LESS "13.1.0")
    set_property(TARGET yajl_fort_parse_example APPEND PROPERTY
                 COMPILE_DEFINITIONS FILL_BUFFER_BY_CHARACTER)
  endif()
endif()
