#ifndef UTILS_H
#define UTILS_H
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void omx_errortype_string(OMX_ERRORTYPE omx_err, char *error_str);
void omx_statetype_string(OMX_STATETYPE state, char *state_str);
void omx_commandtype_string(OMX_COMMANDTYPE cmd, char *command_str);

#endif


