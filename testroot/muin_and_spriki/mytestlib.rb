
# Test library for Spriki system testing.
# <hasan@hypernumbers.com>

$LOAD_PATH << File.join(ENV["HYPERNUMBERS_SVNROOT"], "priv", "ruby")
require "hypernumbers"

# I want to colorize my output. (Using ANSI escape codes.)
class String
  def ansi_red
    "\e[31m#{self}\e[0m"
  end

  def ansi_green
    "\e[32m#{self}\e[0m"
  end
end


def batch_post(data)
  hn = Hypernumbers::Connection.new("127.0.0.1", 9000)
  
  data.each do |d|
    hn.sheet = d[:sheet]
    
    d[:data].each do |cv|
      hn.post(cv[0], cv[1])
    end
  end
end


# Compare the answers, complain if not equal.
def compare(answers)
  hn = Hypernumbers::Connection.new("127.0.0.1", 9000)
  answers.each do |a|
    hn.sheet = a[:sheet]

    a[:data].each do |cv|
      srv_val = hn.get(cv[0])
      if srv_val == cv[1].to_f
        puts "#{hn.sheet}#{cv[0].to_s} #{"OK".ansi_green} (#{srv_val})"
      else
        puts "#{hn.sheet}#{cv[0].to_s} #{"FAIL".ansi_red}: #{srv_val} <> #{cv[1]}"
      end
    end
  end
end
