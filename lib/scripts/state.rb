# frozen_string_literal: true

module MUD
  # Player State
  class State
    attr_reader :chapter, :dialog

    def initialize(state)
      state.map(&:to_a).each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end
  end
end
