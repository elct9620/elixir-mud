# frozen_string_literal: true

# The MUD Game Core
module MUD
  class GameError < RuntimeError; end

  # Initialize MUD System
  #
  # @since 0.1.0
  def self.init
    Story.instance
  end
end

require 'mud/story'
require 'mud/context'
