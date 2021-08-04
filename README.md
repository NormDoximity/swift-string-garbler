# ssg - swift string garbler

- "garble garble" - 🦃 

Hides sensitive strings that get embedded in your app's binary.



```
USAGE: ssg-command [--environment-path <environment-path>] [--checksum-path <checksum-path>] [--template-path <template-path>] [--verbose] [--prioritize-alternative-keys] <output-path>

ARGUMENTS:
  <output-path>           Path to generated file.

OPTIONS:
  -e, --environment-path <environment-path>
                          Path to alternative keys file (defaults to .env)
  -c, --checksum-path <checksum-path>
                          Path to variable checksum file.
  -t, --template-path <template-path>
                          Path to custom output template.
  -v, --verbose           Enable verbose reporting.
  -p, --prioritize-alternative-keys
                          Prefer using alternative keys to keys found in runtime environment.
  -h, --help              Show help information.
```

## Description

`ssg` reads key names and values from an input file we call the environment. The format 
of the file is a JSON file where each key represents the name of the string you want to garble 
and the value is the string you want to garble. An example file is below:

```
{
    "key1": "value1",
    "key2": "value2",
    "key3": "value3"
}
```

The values strings are read by `ssg`, garbled, and the [resulting output](https://github.com/NormDoximity/swift-string-garbler/blob/main/Tests/ssgTests/ProjectKeys.swift) is a swift source file you
can include in your app project. `ssg` will use the values specified in the environment file, unless a
corresponding key is found as an environment variable in the run time environment of the executing process.
Should an environment variable be found, that value will be used instead of the value in the passed in 
file.

Although you can use `ssg` in an ad-hoc capacity, ideally you will want to use this as a build phase in 
your project. To avoid having to rebuild the source each time you run `ssg` and there are no environment
file changes, `ssg` can create a checkusm of the key values pairs found in it's environment. Providing 
a filesname with `--checksum-path` option will read the checksum from a previous run and compare it 
to the new checksum computed from the environment. Should they differ, the new checksum is written at 
the checksum path and a new swift source file is created.

### Leaving Comments
`ssg` supports comments in the JSON file if they have the prefix of `__COMMENT__`. When `ssg` encounters these, those entires are just skipped.
```
{
    "__COMMENT__IMPORTANT-PLEASE-READ": "This is a very important note that we want future updaters to read when editing this file!",

    "key1": "value1",
    "key2": "value2",
    "__COMMENT__Key-3": "This is a very important note specific to key3!",
    "key3": "value3"
}
```
