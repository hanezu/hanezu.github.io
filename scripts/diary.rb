require "date"
require_relative 'rename'


module Diary


  def Diary.default_name
    date = Date.today.to_s
    date + '-' + date + '.md'
  end

  def Diary.init(diary, has_img=false, has_credit=false)
    buffer = []
    buffer << '---'
    buffer << 'layout: post'
    buffer << "title: \"#{diary}\""
    buffer << 'categories: journal'
    buffer << 'tags: [,]'
    if has_img
      buffer << 'image:'
      buffer << '  feature: .jpg'
      buffer << '  teaser: .jpg'
    end
    if has_credit
      buffer << '  credit:'
      buffer << '  creditlink:'
    end
    buffer << '---'
    buffer << ''
    buffer << '1. TOC'
    buffer << '{:toc}'
    File.open(Name.path_from_title(diary), 'w') do |file|
      file.write(buffer.join("\n"))
    end
  end

  def Diary.vim diary
    system('vim', diary)
  end

  def Diary.edit diary
    `open -a MacVim.app #{diary}`
  end
end
