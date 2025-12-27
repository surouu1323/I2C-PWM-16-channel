#!/bin/csh

set cov = 0

# clean trước
make clean

# nếu tham số đầu tiên là "cov" thì bật cov
if ( "$1" == "cov" ) then
    set cov = 1
endif

# đọc từng dòng trong pat.list
foreach pat (`cat pat.list`)
    echo $pat

    # bỏ qua nếu có chứa //
    echo $pat | grep -q "//"
    if ( $status != 0 ) then
        if ( $cov == 1 ) then
            make all_cov TESTNAME=$pat
        else
            make all TESTNAME=$pat
        endif
    endif
end

# nếu cov thì chạy thêm gen_cov
if ( $cov == 1 ) then
    make gen_cov
endif
