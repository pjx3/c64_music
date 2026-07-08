#ifndef WIZBALL_AUDIO_H
#define WIZBALL_AUDIO_H

/* SID access is abstracted behind callbacks so the translated driver can run off-C64. */

#include <stddef.h>
#include <stdint.h>

struct WizballDriver;

typedef struct WizballSidBackend {
    void *context;
    void (*set_voice_frequency)(void *context, size_t voice, uint16_t frequency);
    void (*set_voice_pulse_width)(void *context, size_t voice, uint16_t pulse_width);
    void (*set_voice_control)(void *context, size_t voice, uint8_t control);
    void (*set_voice_attack_decay)(void *context, size_t voice, uint8_t value);
    void (*set_voice_sustain_release)(void *context, size_t voice, uint8_t value);
    void (*set_filter_cutoff)(void *context, uint16_t cutoff);
    void (*set_filter_resonance)(void *context, uint8_t value);
    void (*set_master_volume)(void *context, uint8_t value);
    void (*reset)(void *context);
} WizballSidBackend;

void wizball_audio_reset(struct WizballDriver *driver);
void wizball_audio_refresh(struct WizballDriver *driver);

#endif
