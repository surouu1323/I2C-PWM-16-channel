#!/bin/csh

set log = "./log/rep.log"
if ( -f $log ) then
    rm -rf $log
endif

touch $log
printf "|--------------------------------------------------------------------------------------|\n" >> $log
printf "|%-40s |%-30s |%-11s |\n" "PAT_NAME" "RUN TIME" "RESULT" >> $log
printf "|--------------------------------------------------------------------------------------|\n" >> $log

set all = 0
set pass = 0
set remain = 0

foreach pat (`grep -Ev "V|//|#" pat.list`)
    @ all = $all + 1
    # echo $pat
    set sim_log = "./log/${pat}.log"
    set res = ""
    set tm  = ""
    
    if ( ! -f $sim_log ) then
        set res = "NA"
        set tm  = "NA"
        echo "can not find $sim_log"
        @ remain = $remain + 1

    else
        # lấy thời gian từ dòng $finish
        set tm = `grep "End time" $sim_log | awk -F"[ :,]" '{print $5 ":" $6 ":" $7 " " $9 " " $10 " " $11}'`

        # lấy PASS/FAIL từ dòng Test_result
        set res = `grep "TEST RESULT" $sim_log | awk -F"[ :,]" '{print $5}'`
        
        if ( "$res" == "PASSED" ) then
            @ pass = $pass + 1
        else
            @ remain = $remain + 1
        endif
    endif

    printf "|%-40s |%-30s |%-11s |\n" "$pat" "$tm" "$res" >> $log
end

printf "|--------------------------------------------------------------------------------------|\n" >> $log

printf "ALL/PASS/REMAIN : %d/%d/%d\n" $all $pass $remain >> $log

cat $log
