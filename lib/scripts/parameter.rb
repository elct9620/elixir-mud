# frozen_string_literal: true

require_relative './state'

module MUD
  # Parameter Manager
  class Parameter
    attr_reader :action, :state, :from

    def initialize(message)
      action, state, @from = message
      @action = action.strip
      @state = State.new(state)
    end
  end
end
