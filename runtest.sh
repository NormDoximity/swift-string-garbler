#! /bin/sh

unset key3
export key3="this is from the environment"
rm -f Tests/ssgTests/checksum.txt
rm -f Tests/ssgTests/ProjectKeys.swift
rm -f Tests/ssgTests/ProjectKeys.py

swift run ssg -e Tests/test-env.env -c Tests/ssgTests/checksum.txt Tests/ssgTests/ProjectKeys.swift
swift test
result=$(swift run ssg -e Tests/test-env.env -c Tests/ssgTests/checksum.txt Tests/ssgTests/ProjectKeys.swift)
if [ "${result}" == "Checksums match. Skipping project keys file creation." ]; then
    echo "Tests passed."
else 
    echo "Test failed recieved as checksum test output ${result}"
fi
swift run ssg -e Tests/test-env.env -t Tests/python-template.tmpl Tests/ssgTests/ProjectKeys.py
result=$(python Tests/ssgTests/ProjectKeys.py)
if [ ${result} == "Success" ]; then
    echo "Alternate template test passed."
else
    echo "Alternate template test FAILED."
fi
