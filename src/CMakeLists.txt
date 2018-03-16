set(SRC yajl_fort.F90 yajl_ext.c f90_assert.F90 json.F90)
set(INC f90_assert.fpp)

set(LIB_MOD_DIR ${CMAKE_CURRENT_BINARY_DIR}/mod_files/)

add_library(yajl_fort ${SRC})

set_target_properties(yajl_fort PROPERTIES
    Fortran_MODULE_DIRECTORY ${LIB_MOD_DIR})

target_include_directories(yajl_fort PUBLIC
    $<BUILD_INTERFACE:${LIB_MOD_DIR}>
    $<INSTALL_INTERFACE:lib>
    PRIVATE
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
)

target_link_libraries(yajl_fort yajl)

install(TARGETS yajl_fort
        EXPORT  yajl_fort
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
)
install(DIRECTORY ${LIB_MOD_DIR} DESTINATION lib)
