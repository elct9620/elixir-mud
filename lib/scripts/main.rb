# frozen_string_literal: true

require_relative './game'

# :nodoc:
module MUD
  def self.create(dest)
    Game.new(dest)
    :ok
  end
end
