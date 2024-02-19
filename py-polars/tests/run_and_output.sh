#!/bin/bash

export RUST_BACKTRACE=1

for path in $(find py-polars/tests/ -name \*.py | grep -v '__init__'); do
    log_path=.env/test_logs/$(printf $path | sed 's/py-polars//g').log
    mkdir -p $log_path
    rmdir $log_path
    echo "$path > $log_path"
    py.test \
        -m "write_disk or slow or benchmark or docs or hypothesis or no_cover or filterwarnings or skip or skipif or xfail or parametrize or usefixtures or tryfirst or trylast or xdist_group" \
        $path \
        2>$log_path >$log_path
done
