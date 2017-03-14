require "date"

def diary_file_name
	date = Date.today.to_s
	date + '-' + date + '.md'
end

system('vim', diary_file_name) if __FILE__==$0
