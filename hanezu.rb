#!/usr/bin/env ruby

require "thor"
require "./scripts/post"
require "./scripts/journal"
require "./scripts/error"
require "./scripts/const"

class Hanezu < Thor
  include PostModule
  include JournalModule
  include ErrorModule
  include ConstantModule

  option :latex, :type => :boolean, :aliases => 'l'
  option :image, :type => :boolean, :aliases => 'i'
  option :draft, :type => :boolean, :aliases => 'd'
  option :vim, :type => :boolean, :aliases => 'v'
  option :chinese, :type => :boolean, :aliases => 'c'
  option :japanese, :type => :boolean, :aliases => 'j'
  desc "new JOURNAL", "create new Journal JOURNAL"

  def new(*name)
    journal = name.join('-')
    journal = journal.gsub(/[^a-zA-Z0-9\-]/, '')  # only remain letters, number and hyphen
      # filename = Name.filename_from_title(journal)
      path = Post.path_of(journal, is_draft=false, is_chinese=options[:chinese], is_japanese=options[:japanese])
      Journal.init(journal, has_img=options[:image], has_latex=options[:latex], is_draft=options[:draft], is_chinese=options[:chinese], is_japanese=options[:japanese]) unless File.file?(path)
    if options[:vim]
      Post.vim path
    end
    puts "Create file #{path} successfully."
  end

  desc "rename", "rename INDEX (default 1) journal to NAME (default the title of the journal)"

  def rename(index=1, name=nil)
    post = post_at Integer(index)

    # default: rename it to match its title
    name ||= Post.title_of(post)

    Post.rename(post, name)
  end

  option :image, :type => :boolean, :aliases => 'i', :desc => "list the latest images added to the images folder and return its link in markdown format"
  option :audio, :type => :boolean, :aliases => 'a', :desc => "list the latest audios added to the audios folder and return its link in markdown format"
  option :video, :type => :boolean, :aliases => 'v', :desc => "list the latest videos added to the videos folder and return its link in markdown format"
  option :folder_num, :type => :numeric, :default => 1, :aliases => 'f'
  option :num_per_folder, :type => :numeric, :default => 1, :aliases => 'n'
  desc "ls", "list (images, videos. default posts)"

  def ls()
    if options[:image]
      ls_folder("images/*/", options[:folder_num], options[:num_per_folder]) do |latest_img|
        img_name = File.basename(latest_img, ".*")
        print "![#{img_name}]({{ site.github.url }}/#{latest_img})\n"
      end
    elsif options[:audio]
      ls_media(:audio, options[:folder_num], options[:num_per_folder])
    elsif options[:video]
      ls_media(:video, options[:folder_num], options[:num_per_folder])
    else
      # default: list posts
      posts = get_posts
      size = posts.size
      posts.each_with_index do |f, idx|
        ridx = size - idx # reversed index
        if ridx > Integer(option[:num_per_folder])
          next
        end
        puts "%2d: #{Post.parse_title(f)}" % ridx
      end
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

    def ls_folder(folder, folder_num, num_per_folder)
      latest_folders = Dir.glob(folder).max_by(folder_num) { |f| File.mtime(f) }
      latest_folders.each_with_index do |latest_folder, idx|
        latest_media = Dir.glob("#{latest_folder}*").max_by(num_per_folder) { |f| File.mtime(f) }
        print "#{idx}. #{latest_folder}\n"
        latest_media.each do |latest_medium|
          yield latest_medium
        end
      end
    end

    def ls_media(type, folder_num, num_per_folder)
      extensions = CONST::EXTENSIONS[type] or raise "Non-defined media type: #{type}"
      ls_folder("#{type}s/*/", folder_num, num_per_folder) do |latest_file|
        ext = File.extname latest_file
        format = extensions[ext] or raise "Non-defined extension: #{ext}"
        print "{% include media.html type='#{type}' src='#{latest_file}' format='#{format}' %}\n"
      end
    end
  end
end

Hanezu.start(ARGV)
