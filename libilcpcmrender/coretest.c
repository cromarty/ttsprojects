#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <semaphore.h>

#include "bcm_host.h"
#include "ilclient.h"

#include "ilcpcmrender.h"



int main() {
	OMX_ERRORTYPE omx_err;
	PCMRENDER_STATE_T *st;

	omx_err = OMX_Init();
	if (omx_err != OMX_ErrorNone)
		return 1;

	omx_err = pcmrender_create(&st, 22050, 1, 16, 5, 2048);
	if (omx_err != OMX_ErrorNone)
		return 1;

	omx_err = pcmrender_delete(st);
	if (omx_err != OMX_ErrorNone)
		return 1;

	return 0;

} // end main


