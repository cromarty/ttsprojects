/*
This file is a part of the NVDA project.
URL: http://www.nvda-project.org/
Copyright 2006-2010 NVDA contributers.
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License version 2.0, as published by
    the Free Software Foundation.
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
This license can be found at:
http://www.gnu.org/licenses/old-licenses/gpl-2.0.html
*/

/*
A modified version of nvdaController.h.  The original is an automatically generated file.

I have created this version for cross-compilation of the
NVDA Controller Client with the mingw compiler under Linux.

It removes comments added by the process that generated the original file
and adds code to either export or import functions depending on build process.

Obviously released under the same version of the GPL as the other components.
See the licence block above which I culled from the corresponding C file.

Mike Ray, May 2016

*/

/* verify that the <rpcndr.h> version is high enough to compile this file*/
#ifndef __REQUIRED_RPCNDR_H_VERSION__
#define __REQUIRED_RPCNDR_H_VERSION__ 475
#endif

#include "rpc.h"
#include "rpcndr.h"

/*
Add -DCOMPILING_CONTROLLER_CLIENT_DLL to CFLAGS in the Makefile
used to build the DLL to cause functions to be exported.
*/
#ifdef COMPILING_CONTROLLER_CLIENT_DLL
#define _DECLSPEC_ __declspec(dllexport)
#else
#define _DECLSPEC_ __declspec(dllimport)
#endif

#ifndef __RPCNDR_H_VERSION__
#error this stub requires an updated version of <rpcndr.h>
#endif // __RPCNDR_H_VERSION__

#ifndef __nvdaController_h__
#define __nvdaController_h__

#if defined(_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

#ifdef __cplusplus
extern "C"{
#endif 

#ifndef __NvdaController_INTERFACE_DEFINED__
#define __NvdaController_INTERFACE_DEFINED__

error_status_t __stdcall _DECLSPEC_ nvdaController_testIfRunning( void);
error_status_t __stdcall _DECLSPEC_ nvdaController_speakText(const wchar_t *text);
error_status_t __stdcall _DECLSPEC_ nvdaController_cancelSpeech( void);
error_status_t __stdcall _DECLSPEC_ nvdaController_brailleMessage(const wchar_t *message);

extern handle_t nvdaControllerBindingHandle;
extern RPC_IF_HANDLE nvdaController_NvdaController_v1_0_c_ifspec;
extern RPC_IF_HANDLE NvdaController_v1_0_c_ifspec;
extern RPC_IF_HANDLE nvdaController_NvdaController_v1_0_s_ifspec;
#endif /* __NvdaController_INTERFACE_DEFINED__ */



#ifdef __cplusplus
}
#endif

#endif


