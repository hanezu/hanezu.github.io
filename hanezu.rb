#!/usr/bin/env ruby

require "thor"
require "./scripts/post"
require "./scripts/journal"
require "./scripts/error"

class Hanezu < Thor
  include PostModule
  include JournalModule
  include ErrorModule

  option :vim, :type => :boolean, :aliases => 'v'
  option :image, :type => :boolean, :aliases => 'i'
  desc "new JOURNAL", "create new Journal JOURNAL"

  def new(journal, open_with=nil)
    # filename = Name.filename_from_title(journal)
    path = Post.path_of(journal)
    Journal.init(journal, has_img=options[:image]) unless File.file?(path)
    case open_with
      when %w{ vim v }
        Post.vim path
      when %w{ edit macvim mac m e }
        Post.edit path
      else
        puts "Create file #{path} successfully."
    end
  end

  desc "rename", "rename INDEX (default 1) journal to NAME (default the title of the journal)"

  def rename(index=1, name=nil)
    post = post_at Integer(index)

    # default: rename it to match its title
    name ||= Post.title_of(post)

    Post.rename(post, name)
  end

  desc "ls", "list posts"

  def ls(length=10)
    posts = get_posts
    size = posts.size
    posts.each_with_index do |f, idx|
      ridx = size - idx # reversed index
      if ridx > Integer(length)
        next
      end
      puts "%2d: #{Post.parse_title(f)}" % ridx
    end
  end

  no_commands do
    def post_at(index)
      get_posts[-Integer(index)] ||
          (raise PostIndexOutOfBoundError, "Index #{index} exceeds post total #{get_posts.length}")
    end

    def get_posts
      # in newest order
      Dir.glob(Post._posts('*.md')).sort_by { |f| File.mtime(f) }
    end
  end
end

Hanezu.start(ARGV)