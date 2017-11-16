require 'fileutils'
require 'date'
require_relative 'error'


module PostModule
  class Post
    POSTS_DIR = 'posts/_posts'
    DRAFT_DIR = '_drafts'

    class << self

      def title_of(path)
        File.open(path).each do |line|
          if line =~ /title:/
            return line.split('"')[1]
          end
        end
        raise ErrorModule::UntitledPostError, "post at #{path} do not have a title!"
      end

      def filename_of(title, is_draft=false)
        prefix = if is_draft
                   ''
                 else
                   Date.today.to_s + '-'
                 end
        prefix + title.gsub(/ /, '-') + '.md'
      end

      def path_of(title, is_draft=false)
        File.join(if is_draft
                    DRAFT_DIR
                  else
                    POSTS_DIR
                  end,
                  filename_of(title, is_draft))
      end

      def tag_of(path)
        File.open(path).each do |line|
          if line =~ /tags:/
            tag_str = line.split(':')[1]
            tag_content = tag_str[tag_str.index('[') + 1, tag_str.index(']') - 2]
            tag_list = tag_content.strip.split(',')
            return tag_list.map(&:strip)
          end
        end
        raise ErrorModule::UntitledPostError, "post at #{path} do not have a title!"

      end

      def parse_title(filename)
        # YYYY-MM-DD-TIT-LE.md
        filename.split('.')[0].split('-')[3..-1].join(' ')
      end

      def rename(path, title)
        new_path = path_of(title)
        if path.downcase == new_path.downcase
          puts "No need for renaming #{path} to #{new_path}"
          return
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

      def vim(post)
        system('vim', post)
      end

      def edit(post)
        `open -a MacVim.app #{post}`
      end
    end
  end
end
