#ifndef WIZBALL_DISPLAY_H
#define WIZBALL_DISPLAY_H

/* VIC-II/screen RAM writes become display backend callbacks in the C translation. */

#include <stddef.h>
#include <stdint.h>

#include "config.h"

struct WizballDriver;

typedef struct WizballScreenBuffer {
    char rows[WIZBALL_SCREEN_ROWS][WIZBALL_SCREEN_COLUMNS + 1];
} WizballScreenBuffer;

typedef struct WizballDisplayBackend {
    void *context;
    void (*clear)(void *context, char fill);
    void (*set_border)(void *context, uint8_t color);
    void (*write_row)(void *context, size_t row, const char *text);
} WizballDisplayBackend;

void wizball_display_init(struct WizballDriver *driver);
void wizball_display_refresh(struct WizballDriver *driver, size_t refresh_index);

#endif
