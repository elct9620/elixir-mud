# frozen_string_literal: true

require_relative './stage'

module MUD
  # Story Chapter
  class Chapter
    class ActionNotFoundError < GameError; end

    def initialize(&block)
      @actions = []
      instance_eval(&block)
    end

    def action(&action)
      @actions << action
    end

    def name(name = nil)
      return @name if name.nil?

      @name = name
    end

    def exec(context)
      action = @actions[context.state.dialog]
      raise ActionNotFoundError, 'Action not found' if action.nil?

      Stage.new(context).play(&action)
    end
  end
end
