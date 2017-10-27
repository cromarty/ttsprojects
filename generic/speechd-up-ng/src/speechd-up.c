
/*
 * speechd-up.c - Simple interface between SpeakUp and Speech Dispatcher
 *
 * Copyright (C) 2004, 2006 Brailcom, o.p.s.
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
 * $Id: speechd-up.c,v 1.12 2006/04/28 11:45:30 hanke Exp $
 */

#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>
#include <assert.h>
#include <stdarg.h>
#include <signal.h>
#include <iconv.h>
#include <ctype.h>

#include <speech-dispatcher/libspeechd.h>


#include "options.h"

#define BUF_SIZE 1024

#define DTLK_STOP 24
#define DTLK_CMD 1

int fd;
fd_set fd_list;
fd_set fd_write;
SPDConnection *conn;

FILE *logfile;

char *spd_spk_pid_file;

void spd_spk_reset(int sig);

void
DBG(int level, char *format, ...)
{
  assert(format != NULL);
  assert(logfile != NULL);

  if(level <= LOG_LEVEL) {
    va_list args;
    int i;
		
    va_start(args, format);
    {
	{
	/* Print timestamp */
	time_t t;
	char *tstr;
	t = time(NULL);
	tstr = (char*) strdup(ctime(&t));
	if (tstr == NULL){
	    fprintf(stderr, "strdup(ctime) failed, can't log");
	    return;
	}
	/* Remove the trailing \n */
	assert(strlen(tstr)>1);
	tstr[strlen(tstr)-1] = 0;
	fprintf(logfile, "[%s] speechd: ", tstr);
	free(tstr);
      }
      for(i=1;i<level;i++){
	fprintf(logfile, " ");
      }
      vfprintf(logfile, format, args);
      fprintf(logfile, "\n");
      fflush(logfile);
    }
    va_end(args);
  }				
}

void
index_marker_callback(size_t msg_id, size_t client_id, SPDNotificationType type,
		      char *index_mark)
{
  DBG(5,"Index Mark Callback");
  int cw = write(fd, index_mark, sizeof(index_mark));
}

#define FATAL(status, format...) { DBG(0, format); exit(status); }

void
speechd_init()
{
  conn = spd_open("speakup", "softsynth", "test", SPD_MODE_THREADED);
  if (conn == 0) FATAL(1, "ERROR! Can't connect to Speech Dispatcher!");
  conn->callback_im=index_marker_callback;
  if (spd_set_notification_on(conn, SPD_INDEX_MARKS )==-1)
	DBG(1,"Error turning on Index Mark Callback");
}

void
speechd_close()
{
  spd_close(conn);
}

int
init_speakup_tables()
{
    FILE* fp_char = fopen ("/proc/speakup/characters", "w");
    if (fp_char)
	{
	    int i=0;
	    
	    fprintf(fp_char,"32 space\n");

	    for (i=33;i<256;i++)
		{
		    
		    fprintf(fp_char,"%d %c\n", i, i );
		}
	    fclose(fp_char);
	}
    else return -1;
	
    
    fp_char = fopen ("/proc/speakup/chartab", "w");
    if (fp_char)
	{
	    int i=0;
	    for (i='a'; i<='z'; i++)
		{
		    fprintf(fp_char,"%d\tALPHA\n", i);
		}
	    for (i='A'; i<='Z'; i++)
		{
		    fprintf(fp_char,"%d\tALPHA\n", i);
		}
	    for (i=128; i<256; i++)
		{
		    fprintf(fp_char,"%d\tALPHA\n", i);
		}
	    fclose(fp_char);
	}
    else return -1;

    return 0;
}

int
process_command(char command, unsigned int param, int pm)
{
    int val, ret;
    static int currate = 5,
    curvol = 5,
	curpitch = 5;
    
    DBG(5, "cmd: %c, param: %d, rel: %d", command, param, pm);
    if (pm != 0)
	pm *= param;
    
    switch(command) {
	    
    case '@':  /* Reset speechd connection */
	DBG(5, "resetting speech dispatcher connection");
	spd_spk_reset(0);
	break;
	
    case 'b': /* set punctuation level */
	switch(param){
	case 0:
	    DBG(5, "[punctuation all]", val);
	    ret = spd_set_punctuation(conn, SPD_PUNCT_ALL);
     /* commented out to stop espeak saying 'capitals all the time
	    *ret = spd_set_capital_letters(conn, SPD_CAP_SPELL);
     */
	    break;
	case 1:
	case 2:
	    DBG(5, "[punctuation some]", val);
	    ret = spd_set_punctuation(conn, SPD_PUNCT_SOME);
	    break;
	case 3:
	    DBG(5, "[punctuation none]", val);
	    ret = spd_set_punctuation(conn, SPD_PUNCT_NONE);
	    break;
	default: DBG(1, "ERROR: Invalid punctuation mode!");
	}
	if (ret == -1) DBG(1, "ERROR: Can't set punctuation mode");
	break;
	
    case 'o': /* set voice */
	switch(param)
	    {
	    case 0:
		DBG(5, "[Voice MALE1]");
		ret = spd_set_voice_type(conn, SPD_MALE1);
		break;
	    case 1:
		DBG(5, "[Voice MALE2]");
		ret = spd_set_voice_type(conn, SPD_MALE2);
		break;
	    case 2:
		DBG(5, "[Voice MALE3]");
		ret = spd_set_voice_type(conn, SPD_MALE3);
		break;
	    case 3:
		DBG(5, "[Voice FEMALE1]");
		ret = spd_set_voice_type(conn, SPD_FEMALE1);
		break;
	    case 4:
		DBG(5, "[Voice FEMALE2]");
		ret = spd_set_voice_type(conn, SPD_FEMALE2);
		break;
	    case 5:
		DBG(5, "[Voice FEMALE3]");
		ret = spd_set_voice_type(conn, SPD_FEMALE3);
		break;
	    case 6:
		DBG(5, "[Voice CHILD_MALE]");
		ret = spd_set_voice_type(conn, SPD_CHILD_MALE);
		break;
	    case 7:
		DBG(5, "[Voice CHILD_FEMALE]");
		ret = spd_set_voice_type(conn, SPD_CHILD_FEMALE);
		break;
	    default:
		DBG(1, "ERROR: Invalid voice %d!", param);
		break;
	    }
	if(ret == -1) DBG(1, "ERROR: Can't set voice!");
	break;
	
    case 'p': /* set pitch command */
	if (pm) curpitch += pm;
	else curpitch = param;
		val = (curpitch - 5) * 20;
		assert((val >= -100) && (val <= +100));
		DBG(5, "[pitch %d, param: %d]", val, param);
		ret = spd_set_voice_pitch(conn, val);
		if (ret == -1) DBG(1, "ERROR: Can't set pitch!");
		break;
		
    case 's': /* speech rate */
	if (pm) currate += pm;
	else currate = param;
	val = (currate * 22) - 100;
	assert((val >= -100) && (val <= +100));
	DBG(5, "[rate %d, param: %d]", val, param);
	ret = spd_set_voice_rate(conn, val);
	if (ret == -1) DBG(1, "ERROR: Invalid rate!");
	break;
	
    case 'f':
	DBG(3, "WARNING: [frequency setting not supported,"
	    "use rate instead]");
	break;
	
    case 'v': 
		if (pm)
			curvol += pm;
		else
			curvol = param;
		val = (curvol * 22) - 100;
		assert((val >= -100) && (val <= +100));
	DBG(5, "[volume %d, param: %d]", val, param);
ret = spd_set_volume(conn, val);
if (ret == -1) DBG(1, "ERROR: Invalid volume!");
	break;
	
    case 'x': 
	DBG(3, "[tone setting not supported]");
	break;
    default:
	DBG(3, "ERROR: [%c: this command is not supported]", command);
    }
    
}

/* Say a single character.

UGLY HACK: Since currently this can either be a character
encountered while moving the cursor, a single character generated
by the application, I use the SSIP KEY command for it. KEY
generally gives more information and gives better result
for pressing keys. However, there might be some bad side-effects
in the situations while the characters are generated by reding
characters when moving with the cursor. It is currently impossible
to distinguish KEYs from CHARacters in Speakup.
*/
void
say_single_character(char *buf, size_t bytes, iconv_t *cd)
{
    char cmd[15];
    char *cuu;
    char *cu;
    size_t in = 1, out = 8;
    size_t enc_bytes;

    assert(buf);
    assert(cd);
    
    cuu = cu = malloc(9*sizeof(char));
    if (cuu == NULL) FATAL(4, "Can't allocate memmory.");


    DBG(5, "Saying single character. Input: |%s|", buf);
    
    enc_bytes = iconv(cd, (char**) &buf, &in, (char**) &cu, &out);
    if (enc_bytes < 0){
	DBG(5, "Couldn't recode this string. Failed.");
	free(cuu);
	return;
    }
	
    /* Put the null at the end of string */
    *cu = 0;
    
    DBG(5, "Saying single character |%s|, %d", cuu);

    /* It seems there is a bug in libspeechd function spd_say_char() */
    {
	snprintf(cmd, 14, "KEY %s", cuu);
	DBG(5, "Saying single character CMD:|%s|", cmd);
	spd_execute_command(conn, "SET SELF PRIORITY TEXT");
	spd_execute_command(conn, cmd);
    }

    free(cuu);
    return;
      
}


int
parse_buf(char *buf, size_t bytes)
{ 
  char helper[20];
  char cmd_type;
  int  n, m;
  unsigned int param;
  int pm;
  int ret;

  iconv_t cd;
  int i;
  int enc_bytes;
  char *start_tag="<speak>";
  char *end_tag="</speak>\x00";
  //char *mark_tag="<mark name=\"%s\">";
  char *pi, *po;
  size_t bytes_left = BUF_SIZE;
  size_t in_bytes;

  char text[BUF_SIZE];

  assert (bytes <= BUF_SIZE);

  /* Initialize ICONV for charset conversion */
  cd = iconv_open("utf-8", SPEAKUP_CODING);
  if (cd == (iconv_t) -1)
      FATAL(1, "Requested character set conversion not possible"
	    "by iconv: %s!", strerror(errno));

  /* Look if the message only contains one character (characters=1) */
  {
        int characters = 0;
	char *c;
	DBG(5, "BUF:|%s|", buf);
	/* Find the first non-whitespace non-controll character,
	   make pointer _c_ point to it. If it is the only character
	   in the string, _characters_ is 1, otherwise different. */
	for (i=0; i<=bytes-1; i++){
	    if (buf[i] != ' '){
		c=buf+i;
		characters++;
		if (characters>1) break;
	    }
	    if ((unsigned) buf[i] < 32){
		characters = -1; break;
	    }

	}

	if (characters == 1){
	    say_single_character(c, bytes-i, cd);
	    iconv_close(cd);
	    return 0;
	} /* else continue parsing the buffer*/
  }

  /* This message contains more than one character. Possibly text and
   embedded commands. */

  pi = buf;
  po = text;
  m = 0;

  strcpy(text,start_tag);
  po=text+strlen(start_tag);

  for(i = 0; i < bytes; i++)
    {
      /* Stop speaking */
      if (buf[i] == DTLK_STOP)
	{
	  spd_cancel(conn);
	  DBG(5, "[stop]");
	  pi = &(buf[i+1]);
	  //po = text;
          strcpy(text,start_tag);
          po=text+strlen(start_tag);
	  m = 0;
	}

      /* Process a command */
      else if (buf[i] == DTLK_CMD)
      {      
	  /* If the digit is signed integer, read the sign.  We have
	     to do it this way because +3, -3 and 3 seem to be three
	     different things in this protocol */
	  i++;
	  if (buf[i] == '+') i++, pm = 1;
	  else if (buf[i] == '-') i++, pm = -1;
	  else pm = 0;		/* No sign */

	  /* Read the numerical parameter (one or more digits) */
	  n = 0;
	  while (isdigit(buf[i]) && n < 15)
	    helper[n++] = buf[i++];
	  if (n) {
	    helper[n] = 0;
	    param = strtol(helper, NULL, 10);
	    cmd_type = buf[i];
	  }

	  if (cmd_type=='i')
	  {
		DBG(5, "Insert Index %d",param);
		sprintf(helper,"<mark name=\"%d\"/>",param);
		strcpy(po,helper);
	 	 pi = &(buf[i+1]);
		po+=strlen(helper);
		*po=0;
	  }
	  else
	  {
            /* If there is some text before this command, say it */
            if (m > 0)
            {
              DBG(5, "text: |%s|", text);
              DBG(5, "[speaking (2)]");
              strcat(text,end_tag);
              spd_say(conn, SPD_MESSAGE, text);
              m = 0;
            }
	    /* Now when we have the command (cmd_type) and it's
	       parameter, let's communicate it to speechd */
	    process_command(cmd_type, param, pm);
	    pi = &(buf[i+1]);
            strcpy(text,start_tag);
            po=text+strlen(start_tag);
	  }
	}
      else
	{
	  /* This is ordinary text, so put the byte into our text
	     buffer for later synthesis. */
	  in_bytes = 1;
	  enc_bytes = iconv(cd, &pi, &in_bytes, &po, &bytes_left);
	  if (enc_bytes == -1) DBG(1,"unknown character in input"); /*;*/
	  else{
	    m++;
	    *po = 0;
	  }	  
	}
    }

  iconv_close(cd);

  /* Finally, say the text we read from /dev/softsynth*/
  assert(m>=0);

  if (m != 0){
    strcpy(po,end_tag);  
    DBG(5,"text: |%s %d|", text, m);
    DBG(5, "[speaking]");
    spd_say(conn, SPD_MESSAGE, text);
    DBG(5,"---");
  }

  return 0;
}

void
spd_spk_terminate(int sig)
{
  DBG(1, "Terminating...");
  /* TODO: Resolve race  */
  speechd_close();
  close(fd);
  fclose(logfile);
  exit(1);
}

void
spd_spk_reset(int sig)
{
  speechd_close();
  speechd_init();
}

int
create_pid_file()
{
    FILE *pid_file;
    int pid_fd;
    struct flock lock;
    int ret;    
      
    /* If the file exists, examine it's lock */
    pid_file = fopen(spd_spk_pid_file, "r");
    if (pid_file != NULL){
        pid_fd = fileno(pid_file);

        lock.l_type = F_WRLCK;
        lock.l_whence = SEEK_SET;
        lock.l_start = 1;
        lock.l_len = 3;

        /* If there is a lock, exit, otherwise remove the old file */
        ret = fcntl(pid_fd, F_GETLK, &lock);
        if (ret == -1){
            fprintf(stderr, "Can't check lock status of an existing pid file.\n");
            return -1;
        }

        fclose(pid_file);
        if (lock.l_type != F_UNLCK){
            fprintf(stderr, "Speechd-Up already running.\n");
            return -1;
        }

        unlink(spd_spk_pid_file);        
    }    
    
    /* Create a new pid file and lock it */
    pid_file = fopen(spd_spk_pid_file, "w");
    if (pid_file == NULL){
        fprintf(stderr, "Can't create pid file in %s, wrong permissions?\n",
                spd_spk_pid_file);
        return -1;
    }
    fprintf(pid_file, "%d\n", getpid());
    fflush(pid_file);

    pid_fd = fileno(pid_file);
    lock.l_type = F_WRLCK;
    lock.l_whence = SEEK_SET;
    lock.l_start = 1;
    lock.l_len = 3;

    ret = fcntl(pid_fd, F_SETLK, &lock);
    if (ret == -1){
        fprintf(stderr, "Can't set lock on pid file.\n");
        return -1;
    }

    return 0;
}

void
destroy_pid_file()
{
    unlink(spd_spk_pid_file);
}


int
main (int argc, char *argv[])
{
  int i;
  size_t chars_read;
  char buf[BUF_SIZE];
  int ret;

  options_set_default();
  options_parse(argc, argv);

  if (!strcmp(PIDPATH, ""))
    spd_spk_pid_file = (char*) strdup("/var/run/speechd-up.pid");
  else
    spd_spk_pid_file = (char*) strdup(PIDPATH"speechd.pid");
  
  if (create_pid_file() == -1) exit(1);


  logfile = fopen(LOG_FILE_NAME, "w+");
  if (logfile == NULL){
    fprintf(stderr, "ERROR: Can't open logfile in %s! Wrong permissions?\n", LOG_FILE_NAME);
    exit(1);
  }

  /* Fork, set uid, chdir, etc. */
  if (SPD_SPK_MODE == MODE_DAEMON){
    daemon(0,0);	   
    /* Re-create the pid file under this process */
    destroy_pid_file();
    if (create_pid_file() == -1) return 1;
  }

  /* Register signals */
  (void) signal(SIGINT, spd_spk_terminate);	
  (void) signal(SIGHUP, spd_spk_reset);

  DBG(1,"Speechd-speakup starts!");

  if (!PROBE_MODE){
      if ((fd = open(SPEAKUP_DEVICE, O_RDWR)) < 0) {
	  DBG(1,"Error while openning the device in read/write mode %d,%s",
	      errno,strerror(errno));
	  DBG(1,"Trying to open the device in the old way.");
	  if ((fd = open(SPEAKUP_DEVICE, O_RDONLY)) < 0) {
	      DBG(1,"Error while openning the device in read mode %d,%s",
		  errno,strerror(errno));
	      FATAL(2, "ERROR! Unable to open soft synth device (%s)\n",
		    SPEAKUP_DEVICE);
	      return -1;
	  }else{
	      DBG(1,"It seems you are using an older version of Speakup "
		  "that doesn't support index marking. This is not a problem "
		  "but some more advanced Speakup's function might not work "
		  "until you upgrade Speakup.");
	  }
	  
      }
      if ( fcntl(fd, F_SETFL, fcntl(fd, F_GETFL) | O_NONBLOCK) == -1) {
	  FATAL(5, "fcntl() failed");
	  return (-1);
      }
  }

  speechd_init();

  if (PROBE_MODE){
      DBG(1, "This is just a probe mode. Not trying to read Speakup's device.\n");     
      DBG(1, "Trying to say something on Speech Dispatcher\n");
      spd_say(conn, SPD_MESSAGE, "Hello! It seems SpeechD-Up works correctly!\n");
      DBG(1, "Trying to close connection to Speech Dispatcher\n");
      spd_close(conn);
      DBG(1, "SpeechD-Up is terminating correctly in probe mode");
      return 0;
  }

  ret = spd_set_data_mode(conn,SPD_DATA_SSML);
  if (ret){
      DBG(1, "ERROR: This version of Speech Dispatcher doesn't support SSML mode.\n"
	  "Please use a newer version of Speech Dispatcher (at least 0.5)");
      FATAL(6, "SSML not supported in Speech Dispatcher");
  }

  if (!DONT_INIT_TABLES){
      ret = init_speakup_tables();
      if (ret){
	  DBG(1, "ERROR: It was not possible to init Speakup /proc tables for\n"
	      "characters and character types."
	      "This error might appear because you use an old version of Speakup!"
	      "If your instalation of Speakup is new:In order for internationalization\n"
	      "or correct Speech Dispatcher support (like sound icons) to be\n"
	      "working, you need to set each entry in /proc/speakup/characters\n"
	      "except for space to its value and each entry in /proc/speakup/chartab"
	      "which represents a valid speakable character to ALPHA.\n");
      }
  }

  while (1){
    FD_ZERO(&fd_list);
    FD_SET(fd, &fd_list);
    if ( select(fd+1, &fd_list, NULL, NULL, NULL) < 0 ) {
      if (errno == EINTR) continue;
      FATAL(5, "select() failed");
      close (fd);
      return -1;
    }
    chars_read = read(fd, buf, BUF_SIZE);
    if (chars_read < 0) {
      FATAL(5, "read() failed");
      close (fd);
      return -1;
    }
    buf[chars_read] = 0;
    DBG(5, "Main loop characters read = %d : (%s)", chars_read, buf);
    parse_buf(buf, chars_read);
  }

  return 0;
}
 

