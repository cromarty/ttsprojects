#!/bin/bash
#
# Give all files the same time stamp to fix a git compile running ./configure again when make is run
#


find . -type f -print0 | xargs -r0 touch --reference .

