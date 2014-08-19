#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <semaphore.h>

#include "bcm_host.h"
#include "ilclient.h"

#include "ilctts_lib.h"
#include "utils.h"



int main() {
	OMX_ERRORTYPE omx_err;
	OMX_STATETYPE state;
	TTSRENDER_STATE_T *st;
	int32_t ret;
		char debug_str[128];
	bcm_host_init();
	omx_err = OMX_Init();
	if (omx_err != OMX_ErrorNone) {
	printf("Failed to initialise OMX\n");
		return 1;
		} else {
				printf("Initialised OMX ok\n");
				}
				

	omx_err = ilctts_create(&st, 22050, 1, 16, 5, 2048);
	if (omx_err != OMX_ErrorNone) {
	printf("Failed to create component\n");
		return 1;
		} else {
				printf("Successfully created component\n");
				}

	ret = ilctts_set_dest(st, "local");
	if (ret < 0) {
		printf("Failed to set audio destination\n");
		return 1;
		} else {
			printf("Successfully set audio destination\n");
			}
			
		
		ret = ilctts_get_state(st, &state);
		if (ret < 0) {
			printf("Failed to get state\n");
			} else {
					omx_statetype_string(state, debug_str);
				printf("Got state: %s\n", debug_str);
				}
		
		
	omx_err = ilctts_delete(st);
	if (omx_err != OMX_ErrorNone) {
	printf("Failed to delete component\n");
		return 1;
		}

	return 0;

} // end main


