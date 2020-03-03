# frozen_string_literal: true

module MUD
  # Story Chapter
  class Chapter
    class DialogNotFoundError < GameError; end

    def initialize(&block)
      @dialogs = []
      instance_eval(&block)
    end

    def dialog(&message)
      @dialogs.push(message)
    end

    def name(name = nil)
      return @name if name.nil?

      @name = name
    end

    def exec(params)
      dialog = @dialogs[params.state.dialog]
      raise DialogNotFoundError, 'Dialog not found' if dialog.nil?

      dialog.call(params)
    end
  end
end
