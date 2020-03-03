# frozen_string_literal: true

require 'pathname'
require_relative './chapter'

module MUD
  # Story Index
  class Index
    class ChapterNotFoundError < GameError; end

    def initialize
      @chapters = {}
      load_chapters
    end

    def route(params)
      chapter = @chapters[params.state.chapter]
      raise ChapterNotFoundError, 'Chapter not found' if chapter.nil?

      actions = chapter.exec(params)
      [:ok, actions, params.from]
    end

    private

    def chapter(name, &block)
      @chapters[name] = Chapter.new(&block)
    end

    def load_chapters
      Dir["#{stories_path}/*.rb"].each do |path|
        instance_eval(File.read(path))
      end
    end

    def stories_path
      @stories_path ||=
        Pathname.new(File.dirname(File.expand_path(__FILE__))).join('stories')
    end
  end
end
