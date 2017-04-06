#!/bin/bash

for TEST in testdata/*.test
do
	echo ${TEST}
	cat ${TEST} | ./testparser.pl
done

