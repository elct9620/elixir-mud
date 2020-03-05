# frozen_string_literal: true

module MUD
  # Reaction Handler
  class Reaction
    include ErlPort::ErlTerm
    include ErlPort::Erlang

    def initialize(pid)
      @pid = pid
    end

    def exec(action, *args)
      cast @pid, Tuple.new([action, args])
    end
  end
end
