# frozen_string_literal: true

require 'legion/extensions/cognitive_fatigue_model/helpers/constants'
require 'legion/extensions/cognitive_fatigue_model/helpers/channel'
require 'legion/extensions/cognitive_fatigue_model/helpers/fatigue_engine'
require 'legion/extensions/cognitive_fatigue_model/runners/cognitive_fatigue_model'

module Legion
  module Extensions
    module CognitiveFatigueModel
      class Client
        include Runners::CognitiveFatigueModel

        def initialize(**)
          @engine = Helpers::FatigueEngine.new
        end

        private

        attr_reader :engine
      end
    end
  end
end
