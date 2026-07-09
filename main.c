#include "wizball.h"

#include <ctype.h>
#include <stdio.h>
#include <string.h>

/*
 * Raster waits, SID register writes, and screen refreshes from the 6502 code are
 * expressed here as structured callbacks so the control flow stays recognizable
 * without hard-wiring the translation to C64 memory-mapped I/O.
 */
static const uint8_t wizball_rest_stream[] = {WIZBALL_REST, 1};

#define WIZBALL_EMPTY_TUNE(name, key, hz, seed) \
    {name, key, hz, seed, \
     {wizball_rest_stream, wizball_rest_stream, wizball_rest_stream}, \
     {sizeof(wizball_rest_stream), sizeof(wizball_rest_stream), sizeof(wizball_rest_stream)}}

const WizballTune wizball_tunes[WIZBALL_TUNE_COUNT] = {
    WIZBALL_EMPTY_TUNE("Filth Raid", 'B', 50, (uint8_t)(1 * 7 - 2)),
    WIZBALL_EMPTY_TUNE("Bonus Music (selected)", 'C', 100, (uint8_t)(2 * 7 - 2)),
    WIZBALL_EMPTY_TUNE("End Of Level", 'D', 50, (uint8_t)(3 * 7 - 2)),
    WIZBALL_EMPTY_TUNE("Title", 'E', 200, (uint8_t)(4 * 7 - 2)),
    WIZBALL_EMPTY_TUNE("Bonus Bass", 'F', 200, (uint8_t)(5 * 7 - 2)),
    WIZBALL_EMPTY_TUNE("Get Ready", 'G', 200, (uint8_t)(6 * 7 - 2)),
    WIZBALL_EMPTY_TUNE("Input Name", 'H', 200, (uint8_t)(7 * 7 - 2)),
    WIZBALL_EMPTY_TUNE("Game Over", 'I', 50, (uint8_t)(8 * 7 - 2)),
    WIZBALL_EMPTY_TUNE("Laboratory", 'J', 200, (uint8_t)(9 * 7 - 2)),
    WIZBALL_EMPTY_TUNE("End Of Bonus", 'K', 50, (uint8_t)(10 * 7 - 2))
};

static const uint8_t wizball_clock_digit_limits[WIZBALL_CLOCK_DIGIT_COUNT] = {10, 10, 10, 6, 10, 6}; /* S0,S1,M0,M1,H0,H1 carry limits for the on-screen clock digits. */

typedef struct NullSidState {
    uint16_t frequency[WIZBALL_CHANNEL_COUNT];
    uint16_t pulse_width[WIZBALL_CHANNEL_COUNT];
    uint8_t control[WIZBALL_CHANNEL_COUNT];
    uint8_t attack_decay[WIZBALL_CHANNEL_COUNT];
    uint8_t sustain_release[WIZBALL_CHANNEL_COUNT];
    uint16_t filter_cutoff;
    uint8_t filter_resonance;
    uint8_t master_volume;
} NullSidState;

static void null_sid_set_voice_frequency(void *context, size_t voice, uint16_t frequency) {
    NullSidState *state = (NullSidState *)context;
    if (voice < WIZBALL_CHANNEL_COUNT) {
        state->frequency[voice] = frequency;
    }
}

static void null_sid_set_voice_pulse_width(void *context, size_t voice, uint16_t pulse_width) {
    NullSidState *state = (NullSidState *)context;
    if (voice < WIZBALL_CHANNEL_COUNT) {
        state->pulse_width[voice] = pulse_width;
    }
}

static void null_sid_set_voice_control(void *context, size_t voice, uint8_t control) {
    NullSidState *state = (NullSidState *)context;
    if (voice < WIZBALL_CHANNEL_COUNT) {
        state->control[voice] = control;
    }
}

static void null_sid_set_voice_attack_decay(void *context, size_t voice, uint8_t value) {
    NullSidState *state = (NullSidState *)context;
    if (voice < WIZBALL_CHANNEL_COUNT) {
        state->attack_decay[voice] = value;
    }
}

static void null_sid_set_voice_sustain_release(void *context, size_t voice, uint8_t value) {
    NullSidState *state = (NullSidState *)context;
    if (voice < WIZBALL_CHANNEL_COUNT) {
        state->sustain_release[voice] = value;
    }
}

static void null_sid_set_filter_cutoff(void *context, uint16_t cutoff) {
    ((NullSidState *)context)->filter_cutoff = cutoff;
}

static void null_sid_set_filter_resonance(void *context, uint8_t value) {
    ((NullSidState *)context)->filter_resonance = value;
}

static void null_sid_set_master_volume(void *context, uint8_t value) {
    ((NullSidState *)context)->master_volume = value;
}

static void null_sid_reset(void *context) {
    memset(context, 0, sizeof(NullSidState));
}

static void null_display_clear(void *context, char fill) {
    WizballScreenBuffer *screen = (WizballScreenBuffer *)context;
    for (size_t row = 0; row < WIZBALL_SCREEN_ROWS; ++row) {
        memset(screen->rows[row], fill, WIZBALL_SCREEN_COLUMNS);
        screen->rows[row][WIZBALL_SCREEN_COLUMNS] = '\0';
    }
}

static void null_display_set_border(void *context, uint8_t color) {
    (void)context;
    (void)color;
}

static void null_display_write_row(void *context, size_t row, const char *text) {
    WizballScreenBuffer *screen = (WizballScreenBuffer *)context;
    if (row >= WIZBALL_SCREEN_ROWS) {
        return;
    }
    snprintf(screen->rows[row], sizeof(screen->rows[row]), "%-40.40s", text);
}

static int null_input_poll(void *context) {
    (void)context;
    return 0;
}

static uint16_t wizball_read_le16(const uint8_t *bytes, size_t offset) {
    return (uint16_t)bytes[offset] | ((uint16_t)bytes[offset + 1] << 8U);
}

static void wizball_write_hex(char *out, size_t out_size, const uint8_t *bytes, size_t count) {
    static const char hex[] = "0123456789ABCDEF";
    size_t cursor = 0;
    if (out_size == 0) {
        return;
    }
    out[0] = '\0';
    for (size_t i = 0; i < count && cursor + 2 < out_size; ++i) {
        out[cursor++] = hex[(bytes[i] >> 4U) & 0x0FU];
        out[cursor++] = hex[bytes[i] & 0x0FU];
        if (cursor + 1 < out_size && i + 1 < count) {
            out[cursor++] = ' ';
        }
    }
    out[cursor] = '\0';
}

static void wizball_set_border(WizballDriver *driver, uint8_t color) {
    if (driver->display.set_border != NULL) {
        driver->display.set_border(driver->display.context, color);
    }
}

static void wizball_write_row(WizballDriver *driver, size_t row, const char *text) {
    if (driver->display.write_row != NULL) {
        driver->display.write_row(driver->display.context, row, text);
    }
}

static uint8_t *wizball_runtime_state_bytes(WizballDriver *driver, size_t channel) {
    switch (channel) {
        case 0: return driver->memory.runtime.s0;
        case 1: return driver->memory.runtime.s1;
        default: return driver->memory.zp2.s2;
    }
}

static uint8_t *wizball_program_bytes(WizballDriver *driver, size_t channel) {
    switch (channel) {
        case 0: return driver->memory.zp2.d0;
        case 1: return driver->memory.runtime.d1;
        default: return driver->memory.zp2.d2;
    }
}

static void wizball_sync_channel_memory(WizballDriver *driver, size_t channel) {
    memcpy(wizball_program_bytes(driver, channel),
           driver->channels[channel].program.bytes,
           WIZBALL_TEMPLATE_BYTES);
    memcpy(wizball_runtime_state_bytes(driver, channel),
           driver->channels[channel].state.bytes,
           WIZBALL_STATE_BYTES);
    driver->memory.zp0.pc[channel] = (uint16_t)driver->channels[channel].stream_offset;
    driver->memory.zp0.clock[channel] = driver->channels[channel].clock;
    driver->memory.zp0.stack_pointer[channel] = driver->channels[channel].stack_pointer;
    driver->memory.zp0.transpose[channel] = driver->channels[channel].transpose;
    driver->memory.zp1.music_flags[channel] = driver->channels[channel].music_enabled ? 1U : 0U;
    driver->memory.zp1.pitch_cursor[channel] = driver->channels[channel].state.pitch_cursor;
    if (channel == 1) {
        driver->memory.zp0.s1f_cursor = driver->channels[channel].state.frequency_cursor;
    } else if (channel == 2) {
        driver->memory.zp0.s2f_cursor = driver->channels[channel].state.frequency_cursor;
    } else {
        driver->memory.zp1.filter_cursor = driver->channels[channel].state.frequency_cursor;
    }
}

static void wizball_update_duration_table(WizballDriver *driver, uint8_t seed) {
    uint8_t value = 0;
    for (size_t i = 0; i < WIZBALL_DURATION_TABLE_BYTES; ++i) {
        value = (uint8_t)(value + seed);
        driver->memory.runtime.duration_table[i] = value;
    }
}

static uint8_t wizball_decode_duration(const WizballDriver *driver, uint8_t duration) {
    if (duration > 0 && duration <= WIZBALL_DURATION_TABLE_BYTES) {
        return driver->memory.runtime.duration_table[duration - 1U];
    }
    return duration;
}

static void wizball_start_note(WizballDriver *driver, size_t channel_index, uint8_t note_index) {
    WizballChannel *channel = &driver->channels[channel_index];
    const uint16_t *freq_table = wizball_frequency_table(driver->standard);
    uint16_t frequency = note_index < WIZBALL_NOTE_COUNT ? freq_table[note_index] : WIZBALL_SILENCE_FREQUENCY;

    channel->state.frequency_cursor = frequency;
    channel->state.bytes[WIZBALL_STATE_FINIT] = (uint8_t)(frequency & 0xFFU);
    channel->state.bytes[WIZBALL_STATE_FINIT + 1] = (uint8_t)(frequency >> 8U);

    if (driver->sid.set_voice_frequency != NULL) {
        driver->sid.set_voice_frequency(driver->sid.context, channel_index, frequency);
    }

    if (driver->sid.set_voice_pulse_width != NULL) {
        driver->sid.set_voice_pulse_width(driver->sid.context,
                                          channel_index,
                                          wizball_read_le16(channel->program.bytes, WIZBALL_VOICE_PINIT));
    }

    if (driver->sid.set_voice_attack_decay != NULL) {
        driver->sid.set_voice_attack_decay(driver->sid.context, channel_index, channel->program.bytes[WIZBALL_VOICE_VADV]);
    }
    if (driver->sid.set_voice_sustain_release != NULL) {
        driver->sid.set_voice_sustain_release(driver->sid.context, channel_index, channel->program.bytes[WIZBALL_VOICE_VSRV]);
    }
    if (driver->sid.set_voice_control != NULL) {
        driver->sid.set_voice_control(driver->sid.context,
                                      channel_index,
                                      (uint8_t)(channel->program.bytes[WIZBALL_VOICE_VWF] & ~0x08U));
    }

    channel->state.pitch_cursor = wizball_read_le16(channel->program.bytes, WIZBALL_VOICE_PINIT);
    channel->state.bytes[WIZBALL_STATE_VWFG] = channel->program.bytes[WIZBALL_VOICE_VWF];
    channel->state.bytes[WIZBALL_STATE_VADSC] = channel->program.bytes[WIZBALL_VOICE_VADSD];
    channel->state.bytes[WIZBALL_STATE_VRC] = channel->program.bytes[WIZBALL_VOICE_VRD];
    channel->state.bytes[WIZBALL_VOICE_PMC] = channel->program.bytes[WIZBALL_VOICE_PMC];
    channel->state.bytes[WIZBALL_VOICE_FMC] = channel->program.bytes[WIZBALL_VOICE_FMC];
    channel->state.bytes[WIZBALL_STATE_PMD0C] = channel->program.bytes[WIZBALL_VOICE_PMD0];
    channel->state.bytes[WIZBALL_STATE_PMD1C] = channel->program.bytes[WIZBALL_VOICE_PMD1];
    channel->state.bytes[WIZBALL_STATE_FMD0C] = channel->program.bytes[WIZBALL_VOICE_FMD0];
    channel->state.bytes[WIZBALL_STATE_FMD1C] = channel->program.bytes[WIZBALL_VOICE_FMD1];
    channel->state.bytes[WIZBALL_STATE_FMD2C] = channel->program.bytes[WIZBALL_VOICE_FMD2];
    channel->state.bytes[WIZBALL_STATE_FMD3C] = channel->program.bytes[WIZBALL_VOICE_FMD3];

    wizball_sync_channel_memory(driver, channel_index);
}

static void wizball_handle_command(WizballDriver *driver, size_t channel_index, uint8_t command) {
    WizballChannel *channel = &driver->channels[channel_index];

    if (channel->stream_offset >= channel->stream_length) {
        channel->music_enabled = false;
        wizball_sync_channel_memory(driver, channel_index);
        return;
    }

    switch (command) {
        case WIZBALL_CMD_TRANSP:
            channel->transpose = (int8_t)channel->stream[channel->stream_offset++];
            break;
        case WIZBALL_CMD_MASTER:
            if (driver->sid.set_master_volume != NULL) {
                driver->sid.set_master_volume(driver->sid.context, channel->stream[channel->stream_offset]);
            }
            ++channel->stream_offset;
            break;
        case WIZBALL_CMD_FILTER:
            driver->filter.filter_channel = (uint8_t)channel_index;
            driver->filter.active = true;
            if (channel->stream_offset < channel->stream_length) {
                driver->filter.state_bytes[WIZBALL_VOICE_FMC] = channel->stream[channel->stream_offset++];
            }
            break;
        case WIZBALL_CMD_TIME:
            if (channel->stream_offset < channel->stream_length) {
                channel->clock = channel->stream[channel->stream_offset++];
            }
            break;
        case WIZBALL_CMD_DISOWN:
            channel->music_enabled = false;
            break;
        default:
            channel->music_enabled = false;
            break;
    }

    wizball_sync_channel_memory(driver, channel_index);
}

static void wizball_music_step(WizballDriver *driver, size_t channel_index) {
    WizballChannel *channel = &driver->channels[channel_index];
    if (!channel->music_enabled) {
        return;
    }

    if (channel->clock > 1U) {
        --channel->clock;
        wizball_sync_channel_memory(driver, channel_index);
        return;
    }

    if (channel->stream == NULL || channel->stream_offset >= channel->stream_length) {
        channel->music_enabled = false;
        wizball_sync_channel_memory(driver, channel_index);
        return;
    }

    uint8_t opcode = channel->stream[channel->stream_offset++];
    if (opcode >= WIZBALL_COMMAND_BASE) {
        wizball_handle_command(driver, channel_index, opcode);
        return;
    }

    if (channel->stream_offset >= channel->stream_length) {
        channel->music_enabled = false;
        wizball_sync_channel_memory(driver, channel_index);
        return;
    }

    uint8_t duration = channel->stream[channel->stream_offset++];
    uint8_t note = opcode;
    if (note >= WIZBALL_DURATION_RELATIVE) {
        note = (uint8_t)(note - WIZBALL_DURATION_RELATIVE);
    }

    if (note != WIZBALL_REST) {
        int transposed = (int)note + channel->transpose;
        if (transposed < 0 || transposed >= WIZBALL_NOTE_COUNT) {
            wizball_start_note(driver, channel_index, WIZBALL_NOTE_COUNT);
        } else {
            wizball_start_note(driver, channel_index, (uint8_t)transposed);
        }
    }

    channel->clock = wizball_decode_duration(driver, duration);
    if (channel->clock == 0U) {
        channel->clock = 1U;
    }
    wizball_sync_channel_memory(driver, channel_index);
}

static void wizball_apply_delta16(uint16_t *value, const uint8_t *bytes, size_t offset) {
    /* The driver stores signed 16-bit gradients in little-endian two's-complement form. */
    int16_t delta = (int16_t)wizball_read_le16(bytes, offset);
    *value = (uint16_t)(*value + delta);
}

static void wizball_sound_step(WizballDriver *driver, size_t channel_index) {
    WizballChannel *channel = &driver->channels[channel_index];
    uint8_t *state = channel->state.bytes;
    if (state[WIZBALL_STATE_VRC] == 0U) {
        return;
    }

    if (state[WIZBALL_STATE_VADSC] > 0U) {
        --state[WIZBALL_STATE_VADSC];
        if (state[WIZBALL_STATE_VADSC] == 0U && driver->sid.set_voice_control != NULL) {
            driver->sid.set_voice_control(driver->sid.context, channel_index, (uint8_t)(state[WIZBALL_STATE_VWFG] & 0xF6U));
        }
    } else if (state[WIZBALL_STATE_VRC] > 0U) {
        --state[WIZBALL_STATE_VRC];
    }

    if (state[WIZBALL_VOICE_PMC] != 0U) {
        if (state[WIZBALL_VOICE_PMDLY] > 0U) {
            --state[WIZBALL_VOICE_PMDLY];
        } else if (state[WIZBALL_STATE_PMD0C] > 0U) {
            --state[WIZBALL_STATE_PMD0C];
            wizball_apply_delta16(&channel->state.pitch_cursor, channel->program.bytes, WIZBALL_VOICE_PMG0);
        } else if (state[WIZBALL_STATE_PMD1C] > 0U) {
            --state[WIZBALL_STATE_PMD1C];
            wizball_apply_delta16(&channel->state.pitch_cursor, channel->program.bytes, WIZBALL_VOICE_PMG1);
        }

        if (driver->sid.set_voice_pulse_width != NULL) {
            driver->sid.set_voice_pulse_width(driver->sid.context, channel_index, channel->state.pitch_cursor);
        }
    }

    if (state[WIZBALL_VOICE_FMC] != 0U) {
        if (state[WIZBALL_VOICE_FMDLY] > 0U) {
            --state[WIZBALL_VOICE_FMDLY];
        } else if (state[WIZBALL_STATE_FMD0C] > 0U) {
            --state[WIZBALL_STATE_FMD0C];
            wizball_apply_delta16(&channel->state.frequency_cursor, channel->program.bytes, WIZBALL_VOICE_FMG0);
        } else if (state[WIZBALL_STATE_FMD1C] > 0U) {
            --state[WIZBALL_STATE_FMD1C];
            wizball_apply_delta16(&channel->state.frequency_cursor, channel->program.bytes, WIZBALL_VOICE_FMG1);
        } else if (state[WIZBALL_STATE_FMD2C] > 0U) {
            --state[WIZBALL_STATE_FMD2C];
            wizball_apply_delta16(&channel->state.frequency_cursor, channel->program.bytes, WIZBALL_VOICE_FMG2);
        } else if (state[WIZBALL_STATE_FMD3C] > 0U) {
            --state[WIZBALL_STATE_FMD3C];
            wizball_apply_delta16(&channel->state.frequency_cursor, channel->program.bytes, WIZBALL_VOICE_FMG3);
        }

        if (driver->sid.set_voice_frequency != NULL) {
            driver->sid.set_voice_frequency(driver->sid.context, channel_index, channel->state.frequency_cursor);
        }
    }

    wizball_sync_channel_memory(driver, channel_index);
}

static void wizball_filter_step(WizballDriver *driver) {
    if (!driver->filter.active) {
        return;
    }

    if (driver->filter.state_bytes[WIZBALL_VOICE_FMDLY] > 0U) {
        --driver->filter.state_bytes[WIZBALL_VOICE_FMDLY];
    } else if (driver->filter.state_bytes[WIZBALL_FILTER_STAGE0] > 0U) {
        --driver->filter.state_bytes[WIZBALL_FILTER_STAGE0];
        wizball_apply_delta16(&driver->filter.cutoff_cursor, driver->filter.state_bytes, WIZBALL_VOICE_FMG0);
    } else if (driver->filter.state_bytes[WIZBALL_FILTER_STAGE1] > 0U) {
        --driver->filter.state_bytes[WIZBALL_FILTER_STAGE1];
        wizball_apply_delta16(&driver->filter.cutoff_cursor, driver->filter.state_bytes, WIZBALL_VOICE_FMG1);
    } else if (driver->filter.state_bytes[WIZBALL_FILTER_STAGE2] > 0U) {
        --driver->filter.state_bytes[WIZBALL_FILTER_STAGE2];
        wizball_apply_delta16(&driver->filter.cutoff_cursor, driver->filter.state_bytes, WIZBALL_VOICE_FMG2);
    } else if (driver->filter.state_bytes[WIZBALL_FILTER_STAGE3] > 0U) {
        --driver->filter.state_bytes[WIZBALL_FILTER_STAGE3];
        wizball_apply_delta16(&driver->filter.cutoff_cursor, driver->filter.state_bytes, WIZBALL_VOICE_FMG3);
    }

    driver->filter.filter_byte = (uint8_t)(driver->filter.cutoff_cursor & 0xFFU);
    if (driver->sid.set_filter_cutoff != NULL) {
        driver->sid.set_filter_cutoff(driver->sid.context, driver->filter.cutoff_cursor);
    }
    if (driver->sid.set_filter_resonance != NULL) {
        driver->sid.set_filter_resonance(driver->sid.context, driver->filter.filter_byte);
    }
}

void wizball_audio_reset(WizballDriver *driver) {
    if (driver->sid.reset != NULL) {
        driver->sid.reset(driver->sid.context);
    }
    if (driver->sid.set_master_volume != NULL) {
        driver->sid.set_master_volume(driver->sid.context, WIZBALL_DEFAULT_MASTER_VOLUME);
    }
    for (size_t i = 0; i < WIZBALL_CHANNEL_COUNT; ++i) {
        memset(driver->channels[i].program.bytes, 0, sizeof(driver->channels[i].program.bytes));
        memset(driver->channels[i].state.bytes, 0, sizeof(driver->channels[i].state.bytes));
        driver->channels[i].state.pitch_cursor = 0;
        driver->channels[i].state.frequency_cursor = 0;
        driver->channels[i].music_enabled = false;
        driver->channels[i].clock = 0;
        wizball_sync_channel_memory(driver, i);
    }
    memset(driver->filter.template_bytes, 0, sizeof(driver->filter.template_bytes));
    memset(driver->filter.state_bytes, 0, sizeof(driver->filter.state_bytes));
    driver->filter.cutoff_cursor = 0;
    driver->filter.filter_channel = 0;
    driver->filter.filter_byte = 0;
    driver->filter.active = false;
}

void wizball_audio_refresh(WizballDriver *driver) {
    ++driver->clock_accumulator;
    wizball_filter_step(driver);
    for (size_t channel = 0; channel < WIZBALL_CHANNEL_COUNT; ++channel) {
        wizball_music_step(driver, channel);
        wizball_sound_step(driver, channel);
    }
}

void wizball_input_init(WizballDriver *driver) {
    memset(&driver->keyscan, 0, sizeof(driver->keyscan));
}

int wizball_input_poll(WizballDriver *driver) {
    int key = 0;
    if (driver->input.poll_key != NULL) {
        key = driver->input.poll_key(driver->input.context);
    }
    if (key == driver->keyscan.boing) {
        if (driver->keyscan.debounce_counter > 0U) {
            --driver->keyscan.debounce_counter;
            driver->keyscan.last_key = 0;
            return 0;
        }
        if (driver->keyscan.repeat_counter > 0U) {
            --driver->keyscan.repeat_counter;
            driver->keyscan.last_key = 0;
            return 0;
        }
        driver->keyscan.repeat_counter = WIZBALL_KEYSCAN_REPEAT;
    } else {
        driver->keyscan.boing = (uint8_t)key;
        driver->keyscan.debounce_counter = WIZBALL_KEYSCAN_DELAY;
        driver->keyscan.repeat_counter = WIZBALL_KEYSCAN_REPEAT;
    }
    driver->keyscan.last_key = (uint8_t)key;
    return key;
}

void wizball_display_init(WizballDriver *driver) {
    if (driver->display.clear != NULL) {
        driver->display.clear(driver->display.context, ' ');
    }
    for (size_t row = 0; row < WIZBALL_SCREEN_ROWS; ++row) {
        memset(driver->screen.rows[row], ' ', WIZBALL_SCREEN_COLUMNS);
        driver->screen.rows[row][WIZBALL_SCREEN_COLUMNS] = '\0';
    }
    driver->cumulative_refresh_speed = 0x0100U;
    driver->refresh_speed = WIZBALL_DEFAULT_REFSP;
    wizball_set_border(driver, 0);
}

static void wizball_render_clock(const WizballDriver *driver, char *out, size_t out_size) {
    snprintf(out,
             out_size,
             "CLK %u%u-%u%u-%u%u SPD %04X RF %u",
             driver->clock_digits[5],
             driver->clock_digits[4],
             driver->clock_digits[3],
             driver->clock_digits[2],
             driver->clock_digits[1],
             driver->clock_digits[0],
             driver->refresh_speed,
             driver->enabled_mask);
}

static void wizball_update_clock(WizballDriver *driver) {
    bool any_active = false;
    for (size_t i = 0; i < WIZBALL_CHANNEL_COUNT; ++i) {
        any_active |= driver->channels[i].music_enabled || driver->channels[i].state.bytes[WIZBALL_STATE_VRC] != 0U;
    }
    if (!any_active) {
        driver->clock_accumulator = 0;
        return;
    }
    if (driver->clock_accumulator < 4U) {
        return;
    }
    driver->clock_accumulator = 0;
    for (size_t i = 0; i < WIZBALL_CLOCK_DIGIT_COUNT; ++i) {
        ++driver->clock_digits[i];
        if (driver->clock_digits[i] < wizball_clock_digit_limits[i]) {
            break;
        }
        driver->clock_digits[i] = 0;
    }
}

void wizball_display_refresh(WizballDriver *driver, size_t refresh_index) {
    char line[WIZBALL_SCREEN_COLUMNS + 1];
    switch (refresh_index) {
        case 0:
            wizball_set_border(driver, 1);
            wizball_render_clock(driver, line, sizeof(line));
            wizball_write_row(driver, 24, line);
            wizball_write_hex(line, sizeof(line), (const uint8_t *)&driver->memory.zp0, sizeof(driver->memory.zp0));
            wizball_write_row(driver, 0, line);
            break;
        case 1:
            wizball_set_border(driver, 1);
            wizball_write_hex(line, sizeof(line), driver->memory.zp2.d0, sizeof(driver->memory.zp2.d0));
            wizball_write_row(driver, 3, line);
            wizball_write_hex(line, sizeof(line), driver->memory.runtime.d1, sizeof(driver->memory.runtime.d1));
            wizball_write_row(driver, 6, line);
            wizball_write_hex(line, sizeof(line), driver->memory.zp2.d2, sizeof(driver->memory.zp2.d2));
            wizball_write_row(driver, 9, line);
            break;
        case 2:
            wizball_set_border(driver, 1);
            wizball_write_hex(line, sizeof(line), driver->memory.runtime.s0, sizeof(driver->memory.runtime.s0));
            wizball_write_row(driver, 15, line);
            wizball_write_hex(line, sizeof(line), driver->memory.runtime.s1, sizeof(driver->memory.runtime.s1));
            wizball_write_row(driver, 17, line);
            wizball_write_hex(line, sizeof(line), driver->memory.zp2.s2, sizeof(driver->memory.zp2.s2));
            wizball_write_row(driver, 19, line);
            break;
        case 3:
            wizball_set_border(driver, 1);
            wizball_write_hex(line, sizeof(line), driver->memory.zp1.cut_template, sizeof(driver->memory.zp1.cut_template));
            wizball_write_row(driver, 12, line);
            wizball_write_hex(line, sizeof(line), driver->memory.zp1.cut_state, sizeof(driver->memory.zp1.cut_state));
            wizball_write_row(driver, 21, line);
            snprintf(line, sizeof(line), "FLT %u CUT %04X MFL %u%u%u",
                     driver->filter.filter_channel,
                     driver->filter.cutoff_cursor,
                     driver->memory.zp1.music_flags[0],
                     driver->memory.zp1.music_flags[1],
                     driver->memory.zp1.music_flags[2]);
            wizball_write_row(driver, 23, line);
            break;
        default:
            break;
    }
    wizball_set_border(driver, 0);
}

void wizball_init(WizballDriver *driver,
                  WizballVideoStandard standard,
                  WizballSidBackend sid,
                  WizballDisplayBackend display,
                  WizballInputBackend input) {
    memset(driver, 0, sizeof(*driver));
    driver->standard = standard;
    driver->sid = sid;
    driver->display = display;
    driver->input = input;
    driver->enabled_mask = 0x07U;
    driver->running = true;
    wizball_display_init(driver);
    wizball_input_init(driver);
    wizball_audio_reset(driver);
}

void wizball_load_tune(WizballDriver *driver, WizballTuneId tune_id) {
    if ((size_t)tune_id >= WIZBALL_TUNE_COUNT) {
        return;
    }

    const WizballTune *tune = &wizball_tunes[tune_id];
    wizball_update_duration_table(driver, tune->duration_seed);
    for (size_t i = 0; i < WIZBALL_CHANNEL_COUNT; ++i) {
        driver->channels[i].stream = tune->channels[i];
        driver->channels[i].stream_length = tune->channel_lengths[i];
        driver->channels[i].stream_offset = 0;
        driver->channels[i].clock = 1;
        /* The original 6502 stacks are preloaded with DEPTH-1 and count downward. */
        driver->channels[i].stack_pointer = WIZBALL_STACK_DEPTH - 1U;
        driver->channels[i].transpose = 0;
        driver->channels[i].music_enabled = true;
        wizball_sync_channel_memory(driver, i);
    }
}

void wizball_refresh(WizballDriver *driver) {
    wizball_audio_refresh(driver);
    wizball_update_clock(driver);
}

void wizball_handle_key(WizballDriver *driver, int key) {
    if (key == 0) {
        return;
    }

    switch (key) {
        case 13:
            ++driver->enabled_mask;
            return;
        case '+':
            ++driver->refresh_speed;
            return;
        case '-':
            if (driver->refresh_speed > 1U) {
                --driver->refresh_speed;
            }
            return;
        case '@':
            driver->refresh_speed = 0x0100U;
            return;
        case '*':
            driver->refresh_speed = 0x0001U;
            return;
        default:
            break;
    }

    int upper = toupper((unsigned char)key);
    for (size_t i = 0; i < WIZBALL_TUNE_COUNT; ++i) {
        if (wizball_tunes[i].trigger_key == upper) {
            wizball_load_tune(driver, (WizballTuneId)i);
            return;
        }
    }
}

void wizball_run_frame(WizballDriver *driver) {
    /* Mirrors DREFRESH: wait for four raster slices, refresh audio, then redraw. */
    const uint16_t *refresh_lines = wizball_refresh_lines(driver->standard);
    for (size_t i = 0; i < WIZBALL_REFRESHES_PER_FRAME; ++i) {
        driver->cumulative_refresh_speed = refresh_lines[i];
        wizball_refresh(driver);
        wizball_display_refresh(driver, i);
    }
    wizball_handle_key(driver, wizball_input_poll(driver));
}

void wizball_run_main_loop(WizballDriver *driver, size_t frame_limit) {
    for (size_t frame = 0; driver->running && frame < frame_limit; ++frame) {
        wizball_run_frame(driver);
    }
}

int main(void) {
    WizballDriver driver;
    NullSidState sid_state;
    WizballScreenBuffer screen;
    WizballSidBackend sid = {
        &sid_state,
        null_sid_set_voice_frequency,
        null_sid_set_voice_pulse_width,
        null_sid_set_voice_control,
        null_sid_set_voice_attack_decay,
        null_sid_set_voice_sustain_release,
        null_sid_set_filter_cutoff,
        null_sid_set_filter_resonance,
        null_sid_set_master_volume,
        null_sid_reset
    };
    WizballDisplayBackend display = {&screen, null_display_clear, null_display_set_border, null_display_write_row};
    WizballInputBackend input = {NULL, null_input_poll};

    memset(&sid_state, 0, sizeof(sid_state));
    memset(&screen, 0, sizeof(screen));

    wizball_init(&driver, WIZBALL_VIDEO_PAL, sid, display, input);
    wizball_load_tune(&driver, WIZBALL_TUNE_FILTH_RAID);
    wizball_run_main_loop(&driver, 1);

    return 0;
}
