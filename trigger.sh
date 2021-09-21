#!/bin/sh

SCRIPTS=(prog1.py prog2.py prog3.py)

run_script(){
# First execution
echo "------- EXECUTION $1 -------"
python $1
if [ $? -eq 0 ]; then
    echo "Successful Execution"
else
    # Second Execution
    echo "Second Execution of $1"
    python $1
    if [ $? -eq 0 ]; then
        echo "Successful Execution of $1"
        return 0
    else
        echo "Failed script $1, log at `pwd`/$2 "
        echo "Script execution failed, please refer the log file `pwd`/$2 " | mail -s "Job Execution Status" jasgared@gmail.com
        return 1
    fi
fi
} 

log_functions(){

for script in ${SCRIPTS[*]}; do
    echo "filename is: $script and extension is ${script%%.*}"
    LOG_FILE=${script%%.*}_`date +%Y.%m.%d-%H.%M.%S`.log
    run_script $script $LOG_FILE 2>&1 | tee $LOG_FILE
    JOB_RETURN=${PIPESTATUS[0]}
    if [ $JOB_RETURN -ne 0 ]; then
        break
    fi
done

}


log_functions

echo "*** Jobs Run ***"