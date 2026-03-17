# frozen_string_literal: true

require_relative 'lib/legion/extensions/cognitive_fatigue_model/version'

Gem::Specification.new do |spec|
  spec.name          = 'lex-cognitive-fatigue-model'
  spec.version       = Legion::Extensions::CognitiveFatigueModel::VERSION
  spec.authors       = ['Esity']
  spec.email         = ['matthewdiverson@gmail.com']

  spec.summary       = 'LEX Cognitive Fatigue Model'
  spec.description   = 'Multi-channel cognitive fatigue modeling for brain-modeled agentic AI'
  spec.homepage      = 'https://github.com/LegionIO/lex-cognitive-fatigue-model'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 3.4'

  spec.metadata['homepage_uri']        = spec.homepage
  spec.metadata['source_code_uri']     = 'https://github.com/LegionIO/lex-cognitive-fatigue-model'
  spec.metadata['documentation_uri']   = 'https://github.com/LegionIO/lex-cognitive-fatigue-model'
  spec.metadata['changelog_uri']       = 'https://github.com/LegionIO/lex-cognitive-fatigue-model'
  spec.metadata['bug_tracker_uri']     = 'https://github.com/LegionIO/lex-cognitive-fatigue-model/issues'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir.glob('{lib,spec}/**/*') + %w[lex-cognitive-fatigue-model.gemspec Gemfile LICENSE]
  end
  spec.require_paths = ['lib']
end
