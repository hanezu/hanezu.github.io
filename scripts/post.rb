require 'fileutils'
require 'date'
require_relative 'error'


module PostModule
  class Post
    POSTS_DIR = '_posts'

    class << self

      # def title_of(path)
      #
      #   File.open(path).each do |line|
      #     if line =~ /title:/
      #       return line.split('"')[1]
      #     end
      #     raise ErrorModule::UntitledPostError, "post at #{path} do not have a title!"
      #   end
      #   ''
      # end

      def filename_of(title)
        Date.today.to_s + '-' + title.gsub(/ /, '-') + '.md'
      end

      def path_of(title)
        _posts(filename_of(title))
      end

      def parse_title(filename)
        # YYYY-MM-DD-TIT-LE.md
        filename.split('.')[0].split('-')[3..-1].join(' ')
      end

      def rename(path, title)
        new_path = path_of(title)
        if path.downcase == new_path.downcase
          puts "No need for renaming #{path} to #{new_path}" and return
        end
        new_file = File.open(new_path, 'w')
        yet_title = true
        File.open(path).each do |line|
          if line =~ /title:/ && yet_title
            prefix = line.split('"')[0]
            new_file.puts "#{prefix}\"#{title}\""
            yet_title = false
          else
            new_file.puts line
          end
        end
        new_file.close
        FileUtils.rm(path) if path && title
      end

      def _posts(dir)
        File.join(POSTS_DIR, dir)
      end

      def vim(post)
        system('vim', post)
      end

      def edit(post)
        `open -a MacVim.app #{post}`
      end
    end
  end
end
