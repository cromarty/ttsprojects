/*
 * options.c - Parse and process possible command line options
 *
 * Copyright (C) 2003,2004 Brailcom, o.p.s.
 *
 * This is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2, or (at your option)
 * any later version.
 *
 * This software is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this package; see the file COPYING.  If not, write to
 * the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA.
 *
 * $Id: options.c,v 1.6 2006/04/23 20:43:54 hanke Exp $
 */

#include <assert.h>
#include "options.h"

#define SPD_OPTION_SET_INT(param) \
    val = strtol(optarg, &tail_ptr, 10); \
    if(tail_ptr != optarg){ \
        param = val; \
    }

void
options_print_help(char *argv[])
{
    assert(argv);
    assert(argv[0]);

    printf("Usage: %s [-{d|s}] [-l {1|2|3|4|5}] [-L=logfile] [-c=encoding] | [-v] | [-h]\n", argv[0]);
    printf("SpeechD-Up -- Interface between Speech Dispatcher and SpeakUp (GNU GPL)\n\n");
    printf("-d, --run-daemon     -      Run as a daemon\n"
    "-s, --run-single     -      Run as single application\n"
    "-l, --log-level      -      Set log level (1..5)\n"
    "-L, --log-file       -      Set log file to path\n"
    "-D, --device         -      Specify the device name of Speakup software synthesis\n"
    "-c, --coding         -      Specify the default encoding to use\n"
    "-t, --dont-init-tables -    Don't rewrite /proc tables for optimal software synthesis\n"
    "-p, --probe          -      Initialize everything and try to say some message\n"
    "                            but don't connect to SpeakUp. For testing purposes.\n"
    "-v, --version        -      Report version of this program\n"
    "-h, --help           -      Print this info\n\n"
    "Copyright (C) 2003,2005 Brailcom, o.p.s.\n"
    "This is free software; you can redistribute it and/or modify it\n"
    "under the terms of the GNU General Public License as published by\n"
    "the Free Software Foundation; either version 2, or (at your option)\n"
    "any later version. Please see COPYING for more details.\n\n"
    "Please report bugs to <speechd-up@bugs.freebsoft.org>\n\n");
}

void
options_print_version(void)
{
    printf("%s %s\n", PACKAGE, VERSION);
    printf("Copyright (C) 2002-2003 Brailcom, o.p.s.\n"
           "GNU Emacs comes with ABSOLUTELY NO WARRANTY.\n"
           "You may redistribute copies of Emacs\n"
           "under the terms of the GNU General Public License.\n"
           "For more information about these matters, see the file named COPYING.\n"
           );
}

void
options_set_default(void)
{
  SPD_SPK_MODE = MODE_DAEMON;
  LOG_LEVEL = 3;
  LOG_FILE_NAME = (char*) strdup("/var/log/speechd-up.log");
  SPEAKUP_DEVICE = (char*) strdup("/dev/softsynth");
  SPEAKUP_CODING = (char*) strdup("iso-8859-1");
  PROBE_MODE = 0;
  DONT_INIT_TABLES=0;
}

void
options_parse(int argc, char *argv[])
{
  char* tail_ptr;
  int c_opt;
  int option_index;
  int val;

  assert (argc>0);
  assert(argv);

  while(1){
    option_index = 0;
    
    c_opt = getopt_long(argc, argv, spd_short_options, spd_long_options,
			&option_index);

    if (c_opt == -1) break;

    switch(c_opt){
    case 'd': 
	SPD_SPK_MODE = MODE_DAEMON;
	break;
    case 's':
	SPD_SPK_MODE = MODE_SINGLE;
	break;
    case 'l':
	SPD_OPTION_SET_INT(LOG_LEVEL);
	break;
    case 'L':
	if (LOG_FILE_NAME != 0) free(LOG_FILE_NAME);
	LOG_FILE_NAME = (char*) strdup(optarg);
      break;
    case 'D':
	if (SPEAKUP_DEVICE != 0) free(SPEAKUP_DEVICE);
	SPEAKUP_DEVICE = (char*) strdup(optarg);
      break;
    case 'c':
	if (SPEAKUP_CODING != 0) free (SPEAKUP_CODING);
	SPEAKUP_CODING = (char*) strdup(optarg);
	break;
    case 'v':
	options_print_version();
	exit(0);
	break;
    case 'h':
	options_print_help(argv);
	exit(0);
	break;
    case 'p':
	PROBE_MODE = 1;
	break;
    case 't':
	DONT_INIT_TABLES = 1;
	break;
    default:
      printf("Error: Unrecognized option\n\n");
      options_print_help(argv);
      exit(1);
    }
  }
}
