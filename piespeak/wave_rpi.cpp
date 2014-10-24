#include "speech.h"

#ifdef USE_ASYNC
// This source file is only used for asynchronous modes

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>
#include <assert.h>
#include <sys/time.h>
#include <time.h>
#include <unistd.h>

#include "wave.h"
#include "debug.h"

static t_wave_callback *my_callback_is_output_enabled = NULL;

#define N_WAV_BUF   10
#define MAX_SAMPLE_RATE 22050
#define FRAMES_PER_BUFFER 512
#define BUFFER_LENGTH (MAX_SAMPLE_RATE*2*sizeof(uint16_t))

static char myBuffer[BUFFER_LENGTH];
static char *myRead = NULL;
static char *myWrite = NULL;
static int out_channels = 1;
static int my_stream_could_start = 0;
static int wave_samplerate;

static int mInCallbackFinishedState = false;
static int userdata[4];

static uint32_t myReadPosition = 0;	// in ms
static uint32_t myWritePosition = 0;

//-- static functions

static void init_buffer () {
	return;
}

static unsigned int get_used_mem () {
	return 0;
}

static void start_stream () {
	return;
}

void wave_flush (void *theHandler) {
	return;
}

static int wave_open_sound () {
	return 0;
}

static void select_device (const char *the_api) {
	return;
}

void wave_set_callback_is_output_enabled (t_wave_callback * cb) {
	return;
}





int wave_init(int samplerate) {
	return 0;
}
void*wave_open(const char* the_api) {
	return NULL;
}

size_t wave_write(void* theHandler, char* theMono16BitsWaveBuffer, size_t theSize) {
	return 0;
}

int wave_close(void* theHandler) {
	return 0;
}

int wave_is_busy(void* theHandler) {
	return 0;
}

void wave_terminate() {
	return;
}

uint32_t wave_get_read_position(void* theHandler) {
	return 0;
}

uint32_t wave_get_write_position(void* theHandler) {
	return 0;
}

int wave_get_remaining_time(uint32_t sample, uint32_t* time) {
	return 0;
}

// general functions
void clock_gettime2(struct timespec *ts) {
	return;
}

void add_time_in_ms(struct timespec *ts, int time_in_ms) {
	return;
}


// for tests
void *wave_test_get_write_buffer() {
	return NULL;
}


#endif
