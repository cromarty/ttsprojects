
## Notes about this test harness ##

### Incremental Development ###

This directory, testlib01, is part one of the incremental testing of the library 
in ../src.

It might become uncompilable as further steps are formed in directories 
../testlibNN, where NN is an incremental number.

### This Test ###

The code in this directory reads from a raw PCM file and sends the PCM data to 
the library functions for rendering on the GPU.

No threads are involved, it's just read and send until end of file.

