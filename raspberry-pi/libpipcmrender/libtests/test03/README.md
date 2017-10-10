
## Third Library Test ##

This version of the test-harness calls espeak to render a single sentence of 
text.

As espeak returns the TTS PCM to the program it submits the data to the consumer 
thread in the library.

This is the first incremental test that actually calls espeak for text-to-speech 
rendering.


