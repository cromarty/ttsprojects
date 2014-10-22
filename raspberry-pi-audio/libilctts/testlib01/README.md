### Notes about this test harness

The -lilctts entry in LDFLAGS must come before the libraries being linked into 
this executable for the function names to resolve.

When I had -lilctts at the end of LDFLAGS the link stage was reporting 
'undefined reference' for all functions in ilclient.a.

### Incremental Development ###

This directory, testlib01, is part one of the incremental of the library in 
../src.

It might become uncompilable as further steps are formed in directories 
../testlibNN, where NN is an incremental number.

