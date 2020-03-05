# frozen_string_literal: true

require_relative './mud'
require_relative './parameter'
require_relative './index'

module MUD
  # :nodoc:
  class Game
    include ErlPort::Erlang

    def initialize(pid)
      @pid = pid
      @index = Index.new

      set_message_handler(&method(:process))
    end

    def process(message)
      Thread.new do
        begin
          params = Parameter.new(message)
          cast @pid, Tuple.new(@index.route(params))
        rescue GameError => e
          cast @pid, Tuple.new([:error, e.message, params.from])
        end
      end
    end
  end
end
