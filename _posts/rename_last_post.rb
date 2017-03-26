require 'fileutils'
require 'date'

def get_title_of post_name
  File.open(post_name).each do |line|
	if line =~ /title:/
	  return line.split('"')[1]
	end
  end
end

def filename_from_title title
  Date.today.to_s + '-' + title.gsub(/ /, '-') + '.md'
end
  
if __FILE__==$0
  newest_post = Dir.glob("*.md").max_by {|f| File.mtime(f)}
  title = get_title_of newest_post
  unless title
	puts "Error"
  end

  FileUtils.mv(newest_post, filename_from_title(title))
end
