require 'date'
require_relative 'vim_diary'

#TODO stop if the file is already opened
filename = diary_file_name
`touch #{filename}`
`open -a MacVim.app #{filename}`
