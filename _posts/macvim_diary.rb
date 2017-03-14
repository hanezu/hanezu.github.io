require "date"

date = Date.today
datestr = date.strftime("%Y-%m-%d")
filename = datestr + '-' + datestr + '.md'
`touch #{filename}`
`open -a MacVim.app #{filename}`
