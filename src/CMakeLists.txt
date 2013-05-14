set(CMAKE_Fortran_MODULE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/mod_files)
add_library(yajl_fort yajl_fort.F90 f90_assert.F90)
install(TARGETS yajl_fort DESTINATION lib)
target_link_libraries(yajl_fort yajl)

install(DIRECTORY ${CMAKE_Fortran_MODULE_DIRECTORY}/ DESTINATION include)
