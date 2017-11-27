#!/usr/bin/env ruby

require "thor"
require "./scripts/post"
require "./scripts/journal"
require "./scripts/error"

class Hanezu < Thor
  include PostModule
  include JournalModule
  include ErrorModule

  option :latex, :type => :boolean, :aliases => 'l'
  option :image, :type => :boolean, :aliases => 'i'
  option :draft, :type => :boolean, :aliases => 'd'
  desc "new JOURNAL", "create new Journal JOURNAL"

  def new(journal, open_with=nil)
    # filename = Name.filename_from_title(journal)
    path = Post.path_of(journal)
    Journal.init(journal, has_img=options[:image], has_latex=options[:latex], is_draft=options[:draft]) unless File.file?(path)
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

  desc "tag", "show tags"

  def tag()
    statistics = Hash.new(0)
    Dir.glob(Post._posts('*.md')).each do |f|
      tags = Post.tag_of(f)
      # puts "#{tags}"
      tags.each do |tag|
        statistics[tag] += 1
      end
      if tags.size == 0
        puts "#{f} has no tags!"
      end
    end
    statistics.sort_by { |k, v| k }.each_with_index do |tag, idx|
      print "%-20s %-5d" % tag
      if idx % 6 == 5
        print "\n"
      end
    end
  end

  option :folder_num, :type => :numeric, :default => 1, :aliases => 'f'
  option :image_num_per_folder, :type => :numeric, :default => 1, :aliases => 'n'
  desc "lsi", "list the latest images added to the images folder and return its link in markdown format"

  def lsi()
    latest_folders = Dir.glob("images/*/").max_by(options[:folder_num]) { |f| File.mtime(f) }
    latest_folders.each_with_index do |latest_folder, idx|
      latest_imgs = Dir.glob("#{latest_folder}*").max_by(options[:image_num_per_folder]) { |f| File.mtime(f) }
      print "#{idx}. #{latest_folder}\n"
      latest_imgs.each do |latest_img|
        img_name = File.basename(latest_img, ".*")
        print "![#{img_name}]({{ site.github.url }}/#{latest_img})\n"
      end
    end
  end

  # TODO: insert picture into post

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