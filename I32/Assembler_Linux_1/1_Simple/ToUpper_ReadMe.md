# Test in Buffer Loads and Timing

The two versions of buffer loading and timing where a test on how the files
would perform different text files.

Strangely the execution time did not change even if less memor look ups where
done by the Version 1

The Tests where run on a 442MB big text file with lorem ipsum.

## ToUpper
time ./ToUpper < ../../TextFileForTiming.txt > /dev/null
- 0,93s user 0,34s system 99% cpu 1,262 total
- 0,97s user 0,27s system 99% cpu 1,248 total
- 0,96s user 0,30s system 99% cpu 1,263 total


## ToUpper2
time ./ToUpper2 < ../../TextFileForTiming.txt > /dev/null
- 0,84s user 0,31s system 99% cpu 1,154 total
- 0,90s user 0,26s system 99% cpu 1,162 total
- 0,90s user 0,27s system 99% cpu 1,167 total


