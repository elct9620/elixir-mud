# frozen_string_literal: true

require_relative './mud'
require_relative './context'
require_relative './story'

module MUD
  # :nodoc:
  class Game
    include ErlPort::Erlang

    def initialize(pid)
      @pid = pid

      set_message_handler(&method(:process))
    end

    def process(args)
      Thread.new do
        begin
          context = Context.new(*args)
          Story.select_by(context)
        rescue GameError => e
          cast @pid, Tuple.new([:error, e.message])
        end
      end
    end
  end
end
