require "date"
require_relative 'post'


module JournalModule

  class Journal

    class << self

      def init(title, has_img=false, has_latex=false, is_draft=true)
        buffer = []
        buffer << '---'
        buffer << 'layout: post'
        buffer << "title: \"#{title.gsub(/-/, ' ')}\""
        buffer << 'categories: journal'
        buffer << 'tags: []'

        if has_img
          buffer << 'image:'
          buffer << '  feature: .jpg'
          buffer << '  teaser: .jpg'
          buffer << '  credit:'
          buffer << '  creditlink:'
        end

        buffer << '---'
        buffer << ''

        if has_latex
          buffer << ''
        end

        # insert table of content
        buffer << '1. TOC'
        buffer << '{:toc}'

        File.open(PostModule::Post.path_of(title, is_draft), 'w') do |file|
          file.write(buffer.join("\n"))
        end
      end
    end
  end
end
