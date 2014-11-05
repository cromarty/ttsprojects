### emacspeak protocol parser using Flex and Bison

Files:

bison-parser/emacspeak.y
flex-lexer/emacspeak.l

Empty directories as yet:

include/
perl-lexer/
src/
yapp-parser/

To make C files from the bison and flex files:

bison -d bison-parser/emacspeak.y

flex flex-lexer/emacspeak.l



