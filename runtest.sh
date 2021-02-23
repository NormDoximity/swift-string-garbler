#! /bin/sh

unset key3
export key3="this is from the environment"
rm -f Tests/ssgTests/checksum.txt
swift run ssg -e Tests/test-env.env -c Tests/ssgTests/checksum.txt Tests/ssgTests/ProjectKeys.swift
swift test
result=$(swift run ssg -e Tests/test-env.env -c Tests/ssgTests/checksum.txt Tests/ssgTests/ProjectKeys.swift)
if [ "${result}" == "Checksums match. Skipping project keys file creation." ]; then
    echo "Tests passed."
else 
    echo "Test failed recieved as checksum test output ${result}"
fi
