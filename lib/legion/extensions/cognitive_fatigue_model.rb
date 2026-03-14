# frozen_string_literal: true

require 'legion/extensions/cognitive_fatigue_model/version'
require 'legion/extensions/cognitive_fatigue_model/helpers/constants'
require 'legion/extensions/cognitive_fatigue_model/helpers/channel'
require 'legion/extensions/cognitive_fatigue_model/helpers/fatigue_engine'
require 'legion/extensions/cognitive_fatigue_model/runners/cognitive_fatigue_model'
require 'legion/extensions/cognitive_fatigue_model/client'

module Legion
  module Extensions
    module CognitiveFatigueModel
      extend Legion::Extensions::Core if Legion::Extensions.const_defined? :Core
    end
  end
end
