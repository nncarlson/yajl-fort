set(CMAKE_Fortran_MODULE_DIRECTORY ${yajlfort_BINARY_DIR}/src/mod_files)
add_library(yajl_fort yajl_fort.F90 f90_assert.F90)
install(TARGETS yajl_fort DESTINATION lib)
target_link_libraries(yajl_fort yajl)

install(CODE "EXECUTE_PROCESS (COMMAND \"${CMAKE_COMMAND}\" -E copy_directory \"${CMAKE_Fortran_MODULE_DIRECTORY}\" \"${CMAKE_INSTALL_PREFIX}/include\")")
