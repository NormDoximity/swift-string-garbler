#! /bin/sh

unset key3
export key3="this is from the environment"
rm -f Tests/ssgTests/checksum.txt
rm -f Tests/ssgTests/ProjectKeys.swift
rm -f Tests/ssgTests/ProjectKeys.py

echo "Encrypt/Decrypt"
swift run ssg -e Tests/test-env.env -k Tests/ssgTests/checksum.txt Tests/ssgTests/ProjectKeys.swift
swift test
echo "Checksum"
result=$(swift run ssg -e Tests/test-env.env -k Tests/ssgTests/checksum.txt Tests/ssgTests/ProjectKeys.swift)
if [ "${result}" == "Checksums match. Skipping project keys file creation." ]; then
    echo "Tests passed."
else
    echo "Test failed recieved as checksum test output ${result}"
fi
echo "User specified template"
swift run ssg -e Tests/test-env.env -t Tests/python-template.tmpl Tests/ssgTests/ProjectKeys.py
result=$(python Tests/ssgTests/ProjectKeys.py)
if [ ${result} == "Success" ]; then
    echo "Alternate template test passed."
else
    echo "Alternate template test FAILED."
fi
echo "Environment requirements"
export key2="this two is from the environment"
export BUILD_ENV="BUILD_ENV"
swift run ssg -e Tests/test-env.env -k Tests/ssgTests/checksum.txt --environment-id BUILD_ENV -r key2 key3 -- Tests/ssgTests/ProjectKeys.swift
if [ $? -ne 0 ]; then
   echo "specific environment variables required test failed."
   exit
fi
export key1="key 1 env"
swift run ssg -e Tests/test-env.env -k Tests/ssgTests/checksum.txt --environment-id BUILD_ENV --env-all-required Tests/ssgTests/ProjectKeys.swift
if [ $? -ne 0 ]; then
   echo "all variables required test failed."
   exit
fi
unset key1
swift run ssg -e Tests/test-env.env -k Tests/ssgTests/checksum.txt --environment-id BUILD_ENV --env-all-required Tests/ssgTests/ProjectKeys.swift
if [ $? -eq 0 ]; then
   echo "all variables required failure test failed."
   exit
fi
swift run ssg -e Tests/test-env.env -k Tests/ssgTests/checksum.txt --environment-id BUILD_ENV -r key1 key2 key3 -- Tests/ssgTests/ProjectKeys.swift
if [ $? -eq 0 ]; then
   echo "missing variable specified test failed."
   exit
fi
echo "All Tests Passed"
