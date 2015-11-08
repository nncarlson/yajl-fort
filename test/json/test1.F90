program test1

  use json
  use,intrinsic :: iso_fortran_env, only: error_unit, output_unit
  implicit none
  
  integer :: stat
  character(:), allocatable :: errmsg
  class(json_value), allocatable :: val
  type(json_array_iterator) :: iter
  class(json_value), pointer :: vptr
  
  call json_from_string ('[1,3.14,true,null,{"a":"b"}]', val, stat, errmsg)
  if (stat /= 0) then
    write(error_unit,'(a)') 'error: ' // errmsg
    stop
  end if
  
  call val%write (output_unit)
  
  select type (val)
  type is (json_array)
    write(output_unit,'(a)') 'JSON value is an array'
    iter = json_array_iterator(val)
    do while (.not.iter%at_end())
      vptr => iter%value()
      call vptr%write (output_unit)
      call iter%next
    end do
  class default
    write(output_unit,'(a)') 'uh oh...'
  end select

end program
