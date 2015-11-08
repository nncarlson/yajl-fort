include_directories(${yajlfort_BINARY_DIR}/src/mod_files)

add_executable (test1 test1.F90)
target_link_libraries(test1 yajl_fort)
