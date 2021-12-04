sum = nil
lines = 0
for line in $stdin do
  line.strip!
  sum ||= Array.new(line.length) {0}
  sum = [sum, line.split(//).map(&:to_i)].transpose.map(&:sum)
  lines += 1
end

gamma = sum.map {|x| x > lines / 2 ? 1 : 0}
epsilon = gamma.map {|x| 1 - x}

print "gamma: #{gamma}"
gamma = eval "0b" + gamma.join.to_s
puts " (#{gamma})"

print "epsilon: #{epsilon}"
epsilon = eval "0b" + epsilon.join.to_s
puts " (#{epsilon})"

puts gamma * epsilon
