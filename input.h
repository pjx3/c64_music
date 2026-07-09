#ifndef WIZBALL_INPUT_H
#define WIZBALL_INPUT_H

/* CIA keyboard matrix scanning is represented as an input polling abstraction. */

#include <stdint.h>

struct WizballDriver;

typedef struct WizballInputBackend {
    void *context;
    int (*poll_key)(void *context);
} WizballInputBackend;

typedef struct WizballKeyScanState {
    uint8_t boing;
    uint8_t last_key;
    uint8_t debounce_counter;
    uint8_t repeat_counter;
} WizballKeyScanState;

void wizball_input_init(struct WizballDriver *driver);
int wizball_input_poll(struct WizballDriver *driver);

#endif
