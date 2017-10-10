/*
*
* utils.c - Contains general utility routines
*
* This file contains utility routines used by the library. For
* example functions to return string descriptions of OMX IL error codes etc.
*
* Copyright (C) 2014, Mike Ray, <mike.ray@btinternet.com>
*
* This is free software; you can redistribute it and/or modify it under the
* terms of the GNU Lesser General Public License as published by the Free
* Software Foundation; either version 3, or (at your option) any later
* version.
*
* This software is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU Lesser General Public License
* along with this package; see the file COPYING.  If not, write to the Free
* Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
* 02110-1301, USA.
*
*--code--*/
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <malloc.h>
#include <time.h>
#include <bcm_host.h>
#include <interface/vcos/vcos_semaphore.h>
#include <interface/vmcs_host/vchost.h>
#include <IL/OMX_Component.h>
#include <IL/OMX_Audio.h>
#include <IL/OMX_Broadcom.h>
#include <pthread.h>

#include "pipcmrender_lib.h"

void omx_errortype_string(OMX_ERRORTYPE omx_err, char *error_str) {
	switch(omx_err) {
		case OMX_ErrorNone:
			sprintf(error_str, "%s", "OMX_ErrorNone");
			break;
		case OMX_ErrorInsufficientResources:
			sprintf(error_str, "%s", "OMX_ErrorInsufficientResources");
			break;
		case OMX_ErrorUndefined:
			sprintf(error_str, "%s", "OMX_ErrorUndefined");
			break;
		case OMX_ErrorInvalidComponentName:
			sprintf(error_str, "%s", "OMX_ErrorInvalidComponentName");
			break;
		case OMX_ErrorComponentNotFound:
			sprintf(error_str, "%s", "OMX_ErrorComponentNotFound");
			break;
		case OMX_ErrorInvalidComponent:
			sprintf(error_str, "%s", "OMX_ErrorInvalidComponent");
			break;
		case OMX_ErrorBadParameter:
			sprintf(error_str, "%s", "OMX_ErrorBadParameter");
			break;
		case OMX_ErrorNotImplemented:
			sprintf(error_str, "%s", "OMX_ErrorNotImplemented");
			break;
		case OMX_ErrorUnderflow:
			sprintf(error_str, "%s", "OMX_ErrorUnderflow");
			break;
		case OMX_ErrorOverflow:
			sprintf(error_str, "%s", "OMX_ErrorOverflow");
			break;
		case OMX_ErrorHardware:
			sprintf(error_str, "%s", "OMX_ErrorHardware");
			break;
		case OMX_ErrorInvalidState:
			sprintf(error_str, "%s", "OMX_ErrorInvalidState");
			break;
		case OMX_ErrorStreamCorrupt:
			sprintf(error_str, "%s", "OMX_ErrorStreamCorrupt");
			break;
		case OMX_ErrorPortsNotCompatible:
			sprintf(error_str, "%s", "OMX_ErrorPortsNotCompatible");
			break;
		case OMX_ErrorResourcesLost:
			sprintf(error_str, "%s", "OMX_ErrorResourcesLost");
			break;
		case OMX_ErrorVersionMismatch:
			sprintf(error_str, "%s", "OMX_ErrorVersionMismatch");
			break;
		case OMX_ErrorNotReady:
			sprintf(error_str, "%s", "OMX_ErrorNotReady");
			break;
		case OMX_ErrorTimeout:
			sprintf(error_str, "%s", "OMX_ErrorTimeout");
			break;
		case OMX_ErrorSameState:
			sprintf(error_str, "%s", "OMX_ErrorSameState");
			break;
		case OMX_ErrorResourcesPreempted:
			sprintf(error_str, "%s", "OMX_ErrorResourcesPreempted");
			break;
		case OMX_ErrorPortUnresponsiveDuringDeallocation:
			sprintf(error_str, "%s", "OMX_ErrorPortUnresponsiveDuringDeallocation");
			break;
		case OMX_ErrorPortUnresponsiveDuringStop:
			sprintf(error_str, "%s", "OMX_ErrorPortUnresponsiveDuringStop");
			break;
		case OMX_ErrorIncorrectStateTransition:
			sprintf(error_str, "%s", "OMX_ErrorIncorrectStateTransition");
			break;
		case OMX_ErrorIncorrectStateOperation:
			sprintf(error_str, "%s", "OMX_ErrorIncorrectStateOperation");
			break;
		case OMX_ErrorUnsupportedSetting:
			sprintf(error_str, "%s", "OMX_ErrorUnsupportedSetting");
			break;
		case OMX_ErrorUnsupportedIndex:
			sprintf(error_str, "%s", "OMX_ErrorUnsupportedIndex");
			break;
		case OMX_ErrorBadPortIndex:
			sprintf(error_str, "%s", "OMX_ErrorBadPortIndex");
			break;
		case OMX_ErrorPortUnpopulated:
			sprintf(error_str, "%s", "OMX_ErrorPortUnpopulated");
			break;
		case OMX_ErrorComponentSuspended:
			sprintf(error_str, "%s", "OMX_ErrorComponentSuspended");
			break;
		case OMX_ErrorDynamicResourcesUnavailable:
			sprintf(error_str, "%s", "OMX_ErrorDynamicResourcesUnavailable");
			break;
		case OMX_ErrorMbErrorsInFrame:
			sprintf(error_str, "%s", "OMX_ErrorMbErrorsInFrame");
			break;
		case OMX_ErrorFormatNotDetected:
			sprintf(error_str, "%s", "OMX_ErrorFormatNotDetected");
			break;
		case OMX_ErrorContentPipeOpenFailed:
			sprintf(error_str, "%s", "OMX_ErrorContentPipeOpenFailed");
			break;
		case OMX_ErrorContentPipeCreationFailed:
			sprintf(error_str, "%s", "OMX_ErrorContentPipeCreationFailed");
			break;
		case OMX_ErrorSeperateTablesUsed:
			sprintf(error_str, "%s", "OMX_ErrorSeperateTablesUsed");
			break;
		case OMX_ErrorTunnelingUnsupported:
			sprintf(error_str, "%s", "OMX_ErrorTunnelingUnsupported");
			break;
		case OMX_ErrorKhronosExtensions:
			sprintf(error_str, "%s", "OMX_ErrorKhronosExtensions");
			break;
		case OMX_ErrorVendorStartUnused:
			sprintf(error_str, "%s", "OMX_ErrorVendorStartUnused");
			break;
		case OMX_ErrorDiskFull:
			sprintf(error_str, "%s", "OMX_ErrorDiskFull");
			break;
		case OMX_ErrorMaxFileSize:
			sprintf(error_str, "%s", "OMX_ErrorMaxFileSize");
			break;
		case OMX_ErrorDrmUnauthorised:
			sprintf(error_str, "%s", "OMX_ErrorDrmUnauthorised");
			break;
		case OMX_ErrorDrmExpired:
			sprintf(error_str, "%s", "OMX_ErrorDrmExpired");
			break;
		case OMX_ErrorDrmGeneral:
			sprintf(error_str, "%s", "OMX_ErrorDrmGeneral");
			break;
		case OMX_ErrorMax:
			sprintf(error_str, "%s", "OMX_ErrorMax");
			break;
		default:
			sprintf(error_str, "%s", "Other");
	}
	return;
} // end omx_errortype_string


void omx_statetype_string(OMX_STATETYPE state, char *state_str) {
	switch(state) {
		case OMX_StateInvalid:
			sprintf(state_str, "%s", "OMX_StateInvalid");
			break;
		case OMX_StateLoaded:
			sprintf(state_str, "%s", "OMX_StateLoaded");
			break;
		case OMX_StateIdle:
			sprintf(state_str, "%s", "OMX_StateIdle");
			break;
		case OMX_StateExecuting:
			sprintf(state_str, "%s", "OMX_StateExecuting");
			break;
		case OMX_StatePause:
			sprintf(state_str, "%s", "OMX_StatePause");
			break;
		case OMX_StateWaitForResources:
			sprintf(state_str, "%s", "OMX_StateWaitForResources");
			break;
		default:
			sprintf(state_str, "%s", "_DEFAULT_");
	}

	return;
} // end omx_state_string

void omx_commandtype_string(OMX_COMMANDTYPE cmd, char *command_str) {
	switch(cmd) {
		case OMX_CommandStateSet:
			sprintf(command_str, "%s", "OMX_CommandStateSet");
			break;
		case OMX_CommandFlush:
			sprintf(command_str, "%s", "OMX_CommandFlush");
			break;
		case OMX_CommandPortDisable:
			sprintf(command_str, "%s", "OMX_CommandPortDisable");
			break;
		case OMX_CommandPortEnable:
			sprintf(command_str, "%s", "OMX_CommandPortEnable");
			break;
		case OMX_CommandMarkBuffer:
			sprintf(command_str, "%s", "OMX_CommandMarkBuffer");
			break;
		default:
			sprintf(command_str, "%s", "_DEFAULT_");
	}
	return;
} // end omx_commandtype_string




