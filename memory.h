#ifndef WIZBALL_MEMORY_H
#define WIZBALL_MEMORY_H

/* These structs mirror the original zero-page and RAM allocations from wizball.asm. */

#include <stdint.h>

#include "config.h"

typedef struct WizballZeroPage0 {
    uint16_t pc[WIZBALL_CHANNEL_COUNT];
    uint8_t clock[WIZBALL_CHANNEL_COUNT];
    uint8_t stack_pointer[WIZBALL_CHANNEL_COUNT];
    int8_t transpose[WIZBALL_CHANNEL_COUNT];
    uint16_t in_word;
    uint16_t s1f_cursor;
    uint16_t s2f_cursor;
    uint16_t out_word;
    uint8_t scratch;
} WizballZeroPage0;

typedef struct WizballZeroPage1 {
    uint16_t pitch_cursor[WIZBALL_CHANNEL_COUNT];
    uint16_t filter_cursor;
    uint8_t cut_template[WIZBALL_FILTER_TEMPLATE_BYTES];
    uint8_t cut_state[WIZBALL_FILTER_STATE_BYTES];
    uint8_t filter_channel;
    uint8_t filter_byte;
    uint8_t music_flags[WIZBALL_CHANNEL_COUNT];
    uint8_t channel;
    uint8_t offset;
} WizballZeroPage1;

typedef struct WizballZeroPage2 {
    uint8_t d0[WIZBALL_TEMPLATE_BYTES];
    uint8_t d2[WIZBALL_TEMPLATE_BYTES];
    uint8_t s2[WIZBALL_STATE_BYTES];
    uint8_t st0l[WIZBALL_STACK_DEPTH];
    uint8_t st0h[WIZBALL_STACK_DEPTH];
    uint8_t st0c[WIZBALL_STACK_DEPTH];
    uint8_t st1l[WIZBALL_STACK_DEPTH];
    uint8_t st1h[WIZBALL_STACK_DEPTH];
} WizballZeroPage2;

typedef struct WizballRuntimeMirror {
    uint8_t d1[WIZBALL_TEMPLATE_BYTES];
    uint8_t s0[WIZBALL_STATE_BYTES];
    uint8_t s1[WIZBALL_STATE_BYTES];
    uint8_t duration_table[WIZBALL_DURATION_TABLE_BYTES];
    uint8_t st1c[WIZBALL_STACK_DEPTH];
    uint8_t st2l[WIZBALL_STACK_DEPTH];
    uint8_t st2h[WIZBALL_STACK_DEPTH];
    uint8_t st2c[WIZBALL_STACK_DEPTH];
} WizballRuntimeMirror;

typedef struct WizballMemoryImage {
    WizballZeroPage0 zp0;
    WizballZeroPage1 zp1;
    WizballZeroPage2 zp2;
    WizballRuntimeMirror runtime;
} WizballMemoryImage;

#endif
