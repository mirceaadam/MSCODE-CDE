#!usr/bin/env bash

umask 0002

INIT_DIR=$(dirname $0)/INIT

for file in `ls -1 $INIT_DIR/ | sort`; do
    file=$INIT_DIR/$file

    if [ -x $file ]; then
        bash $file
    fi
done

echo -e "Have fun creating wonderfull things!"