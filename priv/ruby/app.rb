# frozen_string_literal: true

require 'mud'

MUD.init

Elixir::Tide::Event.add_listener('input') do |action|
  context = MUD::Context.new(reaction, state, action)
  MUD::Story.select_by(context)
end
