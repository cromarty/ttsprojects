COMPATNUM=@LIBTOOL_VERSION_INFO@
lib_LTLIBRARIES = libilctts.la
libilctts_la_SOURCES = core.c debug.c ilclient.c ilcore.c ringbuffer.c utils.c core.h debug.h ilclient.h ilctts_lib.h ringbuffer.h utils.h

ilcttsincludedir = ${includedir}/ilctts
ilcttsinclude_HEADERS = ilctts_lib.h utils.h


AM_CPPFLAGS = -I/opt/vc/include -I/opt/vc/include/interface/vcos/pthreads
AM_CPPFLAGS += -I/opt/vc/include/interface/vmcs_host/linux 
AM_CPPFLAGS += -DSTANDALONE -D__STDC_CONSTANT_MACROS -D__STDC_LIMIT_MACROS -DTARGET_POSIX -D_LINUX -DPIC 
AM_CPPFLAGS += -D_REENTRANT -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64
AM_CPPFLAGS += -DHAVE_LIBOPENMAX=2 -DOMX -DOMX_SKIP64BIT -DUSE_EXTERNAL_OMX -DHAVE_LIBBCM_HOST 
AM_CPPFLAGS += -DUSE_EXTERNAL_LIBBCM_HOST -DUSE_VCHIQ_ARM 

libilctts_la_LDFLAGS = -version-info $(COMPATNUM) -Wl,--verbose
