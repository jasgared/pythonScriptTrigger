#!/bin/sh

run_script(){
# First execution
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
        echo "Failed script $1" | mail -s "Job Execution Status" jasgared@gmail.com
        exit 0
    fi
fi
}


run_script prog1.py
run_script prog2.py
run_script prog3.py

echo "**** Successful Executions ****"
