require 'date'
require_relative 'vim_diary'

filename = diary_file_name
init_diary_file(filename) unless File.file?(filename)
`open -a MacVim.app #{filename}`
