# frozen_string_literal: true

module MUD
  # Player Context
  class Context
    attr_reader :reaction, :state, :input

    # @param reaction [Tide::Reaction] the reaction
    # @param state [Tide::State] the state
    # @param input [String] the user input
    def initialize(reaction, state, input)
      @reaction = reaction
      @state = state
      @input = input
    end
  end
end
