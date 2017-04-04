require "date"
require_relative 'post'


module JournalModule

  class Journal

    class << self

      def init(diary, has_img=false)
        buffer = []
        buffer << '---'
        buffer << 'layout: post'
        buffer << "title: \"#{diary}\""
        buffer << 'categories: journal'
        buffer << 'tags: [,]'

        if has_img
          buffer << 'image:'
          buffer << '  feature: .jpg'
          buffer << '  teaser: .jpg'
          buffer << '  credit:'
          buffer << '  creditlink:'
        end

        buffer << '---'
        buffer << ''

        # insert table of content
        buffer << '1. TOC'
        buffer << '{:toc}'

        File.open(PostModule::Post.path_of(diary), 'w') do |file|
          file.write(buffer.join("\n"))
        end
      end
    end
  end
end
