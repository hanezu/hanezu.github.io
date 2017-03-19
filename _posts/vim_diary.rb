require "date"

def diary_file_name
  date = Date.today.to_s
  date + '-' + date + '.md'
end

def init_diary_file diary
  buffer = []
  buffer << '---'
  buffer << 'layout: post'
  buffer << "title: \"#{Date.today.to_s}\""
  buffer << 'categories: journal'
  buffer << 'tags: [,]'
  buffer << 'image:'
  buffer << '  feature: .jpg'
  buffer << '  teaser: .jpg'
  buffer << '  credit:'
  buffer << '  creditlink:'
  buffer << '---'
  buffer << ''
  buffer << '{:toc}'
  File.open(diary, 'w') do |file|
	file.write(buffer.join("\n"))
  end
end

if __FILE__==$0
  diary = diary_file_name
  init_diary_file(diary) unless File.file?(diary)
  system('vim', diary) 
end
