#ifndef WIZBALL_H
#define WIZBALL_H

/* High-level driver state that preserves the assembly driver's 3-channel architecture. */

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#include "audio.h"
#include "config.h"
#include "display.h"
#include "input.h"
#include "memory.h"

typedef struct WizballVoiceTemplate {
    uint8_t bytes[WIZBALL_TEMPLATE_BYTES];
} WizballVoiceTemplate;

typedef struct WizballVoiceState {
    uint8_t bytes[WIZBALL_STATE_BYTES];
    uint16_t pitch_cursor;
    uint16_t frequency_cursor;
} WizballVoiceState;

typedef struct WizballChannel {
    const uint8_t *stream;
    size_t stream_length;
    size_t stream_offset;
    WizballVoiceTemplate program;
    WizballVoiceState state;
    uint16_t call_stack[WIZBALL_STACK_DEPTH];
    uint8_t loop_stack[WIZBALL_STACK_DEPTH];
    uint8_t clock;
    uint8_t stack_pointer;
    int8_t transpose;
    bool music_enabled;
} WizballChannel;

typedef struct WizballFilterState {
    uint8_t template_bytes[WIZBALL_FILTER_TEMPLATE_BYTES];
    uint8_t state_bytes[WIZBALL_FILTER_STATE_BYTES];
    uint16_t cutoff_cursor;
    uint8_t filter_channel;
    uint8_t filter_byte;
    bool active;
} WizballFilterState;

typedef struct WizballTune {
    const char *name;
    char trigger_key;
    uint16_t refresh_hz;
    uint8_t duration_seed;
    const uint8_t *channels[WIZBALL_CHANNEL_COUNT];
    size_t channel_lengths[WIZBALL_CHANNEL_COUNT];
} WizballTune;

typedef struct WizballDriver {
    WizballVideoStandard standard;
    WizballMemoryImage memory;
    WizballChannel channels[WIZBALL_CHANNEL_COUNT];
    WizballFilterState filter;
    WizballSidBackend sid;
    WizballDisplayBackend display;
    WizballInputBackend input;
    WizballKeyScanState keyscan;
    WizballScreenBuffer screen;
    uint8_t clock_digits[6];
    uint8_t clock_accumulator;
    uint16_t cumulative_refresh_speed;
    uint16_t refresh_speed;
    uint8_t enabled_mask;
    bool running;
} WizballDriver;

extern const WizballTune wizball_tunes[WIZBALL_TUNE_COUNT];

void wizball_init(WizballDriver *driver,
                  WizballVideoStandard standard,
                  WizballSidBackend sid,
                  WizballDisplayBackend display,
                  WizballInputBackend input);
void wizball_load_tune(WizballDriver *driver, WizballTuneId tune_id);
void wizball_refresh(WizballDriver *driver);
void wizball_run_frame(WizballDriver *driver);
void wizball_run_main_loop(WizballDriver *driver, size_t frame_limit);
void wizball_handle_key(WizballDriver *driver, int key);

#endif
