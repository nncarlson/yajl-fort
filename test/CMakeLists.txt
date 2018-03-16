add_executable(json-strip strip.F90)
target_link_libraries(json-strip yajl_fort)

add_test(NAME strip-file1 COMMAND
    ${CMAKE_CURRENT_SOURCE_DIR}/strip-cmp.sh json-strip
    ${CMAKE_CURRENT_SOURCE_DIR}/file1.json)
    
# Tests for json.F90; also exercise yajl_fort.F90
foreach(n RANGE 1 9)
  add_executable(json-ex${n} json-ex${n}.f90)
  target_link_libraries(json-ex${n} yajl_fort)
  add_test(json-ex${n} json-ex${n})
endforeach()
