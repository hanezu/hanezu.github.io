require "date"
require_relative 'post'


module Journal


  def Journal.default_name
    date = Date.today.to_s
    date + '-' + date + '.md'
  end

  def Journal.init(diary, has_img=false)
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
      buffer << '  credit:'
      buffer << '  creditlink:'
    end

    buffer << '---'
    buffer << ''

    # insert table of content
    buffer << '1. TOC'
    buffer << '{:toc}'

    File.open(Post.path_from_title(diary), 'w') do |file|
      file.write(buffer.join("\n"))
    end
  end

  def Journal.vim diary
    system('vim', diary)
  end

  def Journal.edit diary
    `open -a MacVim.app #{diary}`
  end
end
