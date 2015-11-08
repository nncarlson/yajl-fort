set(CMAKE_Fortran_MODULE_DIRECTORY ${CMAKE_BINARY_DIR}/src/mod_files)
include_directories(${YAJL_INCLUDE_DIR} ${CMAKE_Fortran_MODULE_DIRECTORY})

set(sources yajl_fort.F90 yajl_ext.c f90_assert.F90)
if(ENABLE_JSON)
  list(APPEND sources json.F90)
endif()

add_library(yajl_fort ${sources})
install(TARGETS yajl_fort DESTINATION lib)
target_link_libraries(yajl_fort ${LIBS})

install(DIRECTORY ${CMAKE_Fortran_MODULE_DIRECTORY}/ DESTINATION include)

### Preprocessor defines
foreach(def ${Fortran_COMPILE_DEFINITIONS})
  set_property (TARGET yajl_fort APPEND PROPERTY COMPILE_DEFINITIONS ${def})
endforeach()
