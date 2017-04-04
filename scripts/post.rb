require 'fileutils'
require 'date'


module Post

  POSTS_DIR = '_posts/'

  def Post.get_title_of post_name
    File.open(post_name).each do |line|
      if line =~ /title:/
        return line.split('"')[1]
      end
    end
  end

  def Post.filename_from_title title
    Date.today.to_s + '-' + title.gsub(/ /, '-') + '.md'
  end

  def Post.path_from_title title
    POSTS_DIR + Post.filename_from_title(title)
  end

  def Post.rename(post, title)
    new_file = File.open(path_from_title(title), 'w')
    yet_title = true
    File.open(post).each do |line|
      if line =~ /title:/ && yet_title
        prefix = line.split('"')[0]
        new_file.puts "#{prefix}\"#{title}\""
        yet_title = false
      else
        new_file.puts line
      end
    end
    new_file.close
    FileUtils.rm(post) if title && post
  end

  def Post.newest_post dir=POSTS_DIR
    Dir.glob("#{dir}*.md").max_by { |f| File.mtime(f) }
  end
end
