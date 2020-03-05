# frozen_string_literal: true

require_relative './reaction'
require_relative './state'

module MUD
  # Player Context
  class Context
    attr_reader :reaction, :state, :input

    # @param reaction [ErlPort::ErlTerm::OpaqueObject] The pid of reaction
    # @param state [Array<ErlPort::ErlTerm::Tuple>] The pid of state
    def initialize(reaction, state, input)
      @reaction = Reaction.new(reaction)
      @state = State.new(state)
      @input = input
    end
  end
end
