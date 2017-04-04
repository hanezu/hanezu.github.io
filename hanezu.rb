#!/usr/bin/env ruby

require "thor"

Dir[File.join(".", "scripts", "*.rb")].each do |f|
  require f
end

class Hanezu < Thor

  option :vim, :type => :boolean, :aliases => 'v'
  option :image, :type => :boolean, :aliases => 'i'
  desc "new JOURNAL", "create new Journal JOURNAL"

  def new(journal)
    # filename = Name.filename_from_title(journal)
    path = Post.path_from_title(journal)
    Journal.init(journal, has_img=options[:image]) unless File.file?(path)
    if options[:vim]
      Journal.vim path
    else
      Journal.edit path
    end
  end


  desc "rename", "rename newest journal"

  def rename(index=1, name=nil)
    post = post_at index
    name ||= Post.get_title_of(post)  # default: rename it to match its title
    Post.rename(post, name)
  end

  desc "ls", "list posts"

  def ls(length=10)
    posts = Dir.glob("#{Post::POSTS_DIR}*.md")
    size = posts.size
    posts.each_with_index do |f, idx|
      ridx = size - idx  # reversed index
      if ridx > length
        next
      end
      puts "%2d: #{Post.get_title_of(f)}" % ridx
    end
  end
end

def post_at index
  posts = Dir.glob("#{Post::POSTS_DIR}*.md")
  posts[-Integer(index)]
end

Hanezu.start(ARGV)
