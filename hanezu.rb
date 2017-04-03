#!/usr/bin/env ruby

require "thor"

Dir[File.join(".", "scripts/*.rb")].each do |f|
  require f
end

class Hanezu < Thor

  option :vim, :type => :boolean, :aliases => 'v'
  option :image, :type => :boolean, :aliases => 'i'
  desc "new JOURNAL", "create new Journal JOURNAL"
  def new(journal)
	# filename = Name.filename_from_title(journal)
	path = Name.path_from_title(journal)
	Diary.init(journal, has_img=options[:image]) unless File.file?(path)
    if options[:vim]
	  Diary.vim path 
	else
	  Diary.edit path
	end
  end

  
  option :index, :type => :numeric, :aliases => 'i'
  option :name, :aliases => 'n'
  desc "rename", "rename newest journal"
  def rename()
	post = if options[:index]
			  post_at(options[:index])
			else
			  Name.newest_post
			end
	name = if options[:name]
			  options[:name]
			else
			  # rename it to match its title
			  Name.get_title_of(post)
			end
	Name.rename(post, name)
  end

  option :length, :type => :numeric, :aliases => 'l' 
  desc "ls", "list posts"
  def ls()
	posts = Dir.glob("#{Name::POSTS_DIR}*.md")
	size = posts.size
    length = options[:length] || 10
	posts.each_with_index do |f, idx|
	  ridx = size - idx
	  if ridx > length
		next
	  end
	  puts "%2d: #{Name.get_title_of(f)}" % ridx
	end
  end
end

def post_at index
  posts = Dir.glob("#{Name::POSTS_DIR}*.md")
  posts[-Integer(index)]
end

Hanezu.start(ARGV)
