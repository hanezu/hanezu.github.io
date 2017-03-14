

require "date"

date = Date.today
datestr = date.strftime("%Y-%m-%d")
filename = datestr + '-' + datestr + '.md'
system('vim', filename)
