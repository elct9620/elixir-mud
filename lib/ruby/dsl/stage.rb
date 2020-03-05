# frozen_string_literal: true

require 'forwardable'

module MUD
  # Stage
  class Stage
    extend Forwardable

    delegate %w[input] => :@context

    def initialize(context)
      @context = context
    end

    def play(&action)
      instance_eval(&action)
    end

    def close
      @context.reaction.exec(:exit)
    end

    def say(message)
      @context.reaction.exec(:msg, message)
    end

    def jump(index)
      @context.reaction.exec(:jmp, index.to_i)
    end

    def wait_input
      @context.reaction.exec(:input)
    end
  end
end
