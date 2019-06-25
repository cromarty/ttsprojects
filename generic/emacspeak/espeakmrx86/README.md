
# emacsespeakx86


A proof-of-concept but useful emacspeak text-to-speech server using
the espeak software speech synthesiser and the parser elsewhere in
this repository.

See ../parser/c/README.md for details of the parser.

## Added in June 2019

I have added a patch:

```
configure.ac.ng.patch
```

Which can be used to patch `configure.ac` to use `libespeak-ng`
instead of `libespeak`.

Using the patch:

```
patch < configure.ac.ng.patch
```

The you will need to run:

```
autoreconf -fi
```


And then build as usual:

```
./configure
make
sudo make install
```


