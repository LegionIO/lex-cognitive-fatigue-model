# lex-cognitive-fatigue-model

**Level 3 Leaf Documentation**
- **Parent**: `/Users/miverso2/rubymine/legion/extensions-agentic/CLAUDE.md`
- **Gem**: `lex-cognitive-fatigue-model`

## Purpose

Models the depletion and recovery of discrete cognitive resource channels. Five channels — attention, working_memory, decision_making, creative, social — each deplete at their own rate when processing tasks and recover at their own rate during rest. The model surfaces delegation and rest recommendations when channels fall below thresholds.

## Gem Info

| Field | Value |
|---|---|
| Gem name | `lex-cognitive-fatigue-model` |
| Version | `0.1.0` |
| Namespace | `Legion::Extensions::CognitiveFatigueModel` |
| Ruby | `>= 3.4` |
| License | MIT |
| GitHub | https://github.com/LegionIO/lex-cognitive-fatigue-model |

## File Structure

```
lib/legion/extensions/cognitive_fatigue_model/
  cognitive_fatigue_model.rb        # Top-level require
  version.rb                        # VERSION = '0.1.0'
  client.rb                         # Client class (in top-level namespace)
  helpers/
    constants.rb                    # Channels, depletion/recovery rates, thresholds
    channel.rb                      # Channel value object
    client.rb                       # Helpers::Client (includes runner)
    fatigue_engine.rb               # Engine: manages five channels
  runners/
    cognitive_fatigue_model.rb      # Runner module
```

## Key Constants

| Constant | Value | Meaning |
|---|---|---|
| `CHANNELS` | array | `[:attention, :working_memory, :decision_making, :creative, :social]` |
| `DEPLETION_RATES` | hash | Per-channel depletion per task (decision_making: 0.06 highest) |
| `RECOVERY_RATES` | hash | Per-channel recovery per rest call (creative: 0.10 fastest) |
| `DEFAULT_ENERGY` | 1.0 | Starting energy for all channels |
| `REST_THRESHOLD` | 0.3 | Channel energy below this triggers rest recommendation |
| `DELEGATION_THRESHOLD` | 0.2 | Channel energy below this triggers delegation recommendation |
| `FATIGUE_LABELS` | hash | `fresh` (0.8+), `alert`, `tired`, `fatigued`, `exhausted` |

## Helpers

### `Channel`

Tracks energy state for one cognitive channel.

- Constructed with channel name; energy starts at `DEFAULT_ENERGY`
- `deplete!` — reduces energy by `DEPLETION_RATES[name]`
- `recover!` — increases energy by `RECOVERY_RATES[name]`
- `needs_rest?` — energy <= `REST_THRESHOLD`
- `needs_delegation?` — energy <= `DELEGATION_THRESHOLD`
- `quality_modifier` — returns a float modifier for task quality at current energy
- `to_h` — includes name, energy, label, flags

### `FatigueEngine`

Owns five pre-initialized channels.

- `initialize` — creates one `Channel` per `CHANNELS` constant
- `process_task(channel_name:)` — depletes channel, returns `to_h`
- `rest_channel(channel_name:)` — recovers channel
- `rest_all` — recovers all channels, returns summary
- `channel_status(channel_name:)` — single channel state
- `overall_fatigue` — mean energy across all channels
- `most_fatigued_channel` — lowest energy channel
- `channels_needing_rest` — array of channels at rest threshold
- `delegation_recommendations` — channels at delegation threshold
- `quality_report` — hash of channel -> quality_modifier
- `to_h` — full state snapshot

### `Helpers::Client`

A secondary client class inside the `Helpers` module that includes the runner directly.

## Runners

**Module**: `Legion::Extensions::CognitiveFatigueModel::Runners::CognitiveFatigueModel`

| Method | Key Args | Returns |
|---|---|---|
| `process_cognitive_task` | `channel_name:` | `{ channel:, overall_fatigue: }` |
| `rest_cognitive_channel` | `channel_name:` | `{ channel: }` |
| `rest_all_channels` | — | Full engine `to_h` |
| `channel_fatigue_status` | `channel_name:` | Channel state hash |
| `overall_fatigue_report` | — | `{ overall_fatigue:, most_fatigued:, channels_needing_rest: }` |
| `fatigue_recommendations` | — | `{ delegate:, rest:, any_action_needed: }` |
| `cognitive_quality_report` | — | `{ quality: { channel => modifier } }` |
| `update_cognitive_fatigue_model` | — | Rests all channels (maintenance method) |
| `cognitive_fatigue_model_stats` | — | engine `to_h` |

Private: `engine` — memoized `FatigueEngine` instance.

## Integration Points

- **`lex-tick`**: `fatigue_recommendations` could gate `action_selection` — if `decision_making` is at delegation threshold, the agent can decline high-stakes autonomous decisions.
- **`lex-consent`**: Low energy channels could inform consent tier demotion, since a fatigued agent may have reduced judgment capacity.
- **`lex-cortex`**: The `update_cognitive_fatigue_model` method is the maintenance runner that `lex-cortex` could invoke periodically.

## Development Notes

- There is a `Helpers::Client` class inside the `helpers/` subdirectory in addition to the top-level `Client`. The top-level client delegates to the runner via include; the helpers client wraps the engine directly.
- All five channels are pre-initialized; there is no dynamic channel creation. Callers always use the fixed channel names from `CHANNELS`.
- In-memory only. No persistence.

---

**Maintained By**: Matthew Iverson (@Esity)
