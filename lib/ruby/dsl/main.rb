# frozen_string_literal: true

require_relative './game'

# :nodoc:
module MUD
  include ErlPort::ErlTerm

  def self.create(dest, pid)
    Game.new(dest)
    Tuple.new([:ok, pid])
  end
end
