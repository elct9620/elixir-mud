# frozen_string_literal: true

require 'singleton'
require 'pathname'
require 'forwardable'
require_relative './chapter'

module MUD
  # Story Manager
  class Story
    class << self
      extend Forwardable

      delegate %w[select_by] => :instance
    end

    class ChapterNotFoundError < GameError; end

    include Singleton

    def initialize
      @chapters = {}
      load_chapters
    end

    def select_by(context)
      chapter = @chapters[context.state.chapter]
      raise ChapterNotFoundError, 'Chapter not found' if chapter.nil?

      chapter.exec(context)
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
