last = 99999
puts $stdin.count {|line| this = line.to_i; [this > last, last = this][0]}
