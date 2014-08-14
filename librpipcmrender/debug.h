
#define DEBUG_INFO

#ifdef DEBUG_INFO

#define debug_log( filespec, fmt, arg... ) \
		fprintf( filespec, fmt, ##arg ); \
		fflush(NULL);

#else

#define debug_log( filespec, fmt, arg... )

#endif

