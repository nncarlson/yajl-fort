set(CMAKE_Fortran_MODULE_DIRECTORY ${CMAKE_BINARY_DIR}/src/mod_files)
include_directories(${YAJL_INCLUDE_DIR})
add_library(yajl_fort yajl_fort.F90 yajl_ext.c f90_assert.F90)
install(TARGETS yajl_fort DESTINATION lib)
target_link_libraries(yajl_fort ${LIBS})

install(DIRECTORY ${CMAKE_Fortran_MODULE_DIRECTORY}/ DESTINATION include)
