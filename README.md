# lex-cognitive-fatigue-model

Multi-channel cognitive fatigue and recovery model for brain-modeled agentic AI in the LegionIO ecosystem.

## What It Does

Cognitive work depletes distinct mental resources at different rates. This extension tracks five independent channels — attention, working_memory, decision_making, creative, and social — each with their own depletion and recovery rates. The model surfaces when channels need rest (below 0.3 energy) or when tasks should be delegated (below 0.2 energy). It also provides a quality modifier per channel, allowing downstream systems to weight outputs from fatigued channels appropriately.

## Usage

```ruby
require 'legion/extensions/cognitive_fatigue_model'

client = Legion::Extensions::CognitiveFatigueModel::Client.new

# Simulate processing a decision-making task
client.process_cognitive_task(channel_name: :decision_making)

# Check what needs attention
client.fatigue_recommendations
# => { delegate: [], rest: [], any_action_needed: false }

# Check overall fatigue
client.overall_fatigue_report
# => { overall_fatigue: 0.94, most_fatigued: { name: :decision_making, energy: 0.94, ... }, channels_needing_rest: [] }

# Rest a specific channel
client.rest_cognitive_channel(channel_name: :decision_making)

# Rest all channels at once (maintenance)
client.rest_all_channels

# Get quality modifiers for all channels
client.cognitive_quality_report
```

## Development

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

## License

MIT
