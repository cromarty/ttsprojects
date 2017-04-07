#!/bin/bash

set -e
[ -d Parse/ ]  || mkdir Parse/
cd Parse/
yapp -m Emacspeak ../../parser/perl/parser.yp
exit 0
