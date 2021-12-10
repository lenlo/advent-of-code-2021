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
gamma =  gamma.join.to_i(2)
puts " (#{gamma})"

print "epsilon: #{epsilon}"
epsilon = epsilon.join.to_i(2)
puts " (#{epsilon})"

puts gamma * epsilon
