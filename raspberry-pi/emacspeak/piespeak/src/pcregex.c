#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <pcre.h>

#include "pcregex.h"

int clean_string(
		const char *buffer,
		char *newbuffer,
		const char *regex,
const char *replacement
)
{
	int rc, offset;
	pcre *re;

	const char *error;
	int erroffset;

	int ovector[OVECCOUNT];

	re = pcre_compile(regex, 0, &error, &erroffset, 0);
 if (re == NULL)
		return -1;

	offset = 0;

	do {
		rc = pcre_exec(re, NULL, buffer, strlen(buffer), offset, 0, ovector, OVECCOUNT);
	if ((rc < 0) && (rc != PCRE_ERROR_NOMATCH) )
		return rc;

	if (rc != PCRE_ERROR_NOMATCH) {
		strncat(newbuffer,buffer+offset, ovector[0]-offset);
		strcat(newbuffer, replacement);
	} else {
		strcat(newbuffer,buffer+offset);
	}

	offset = ovector[1];

	} while (rc > 0);

	return 0;

} /* end clean_string */
