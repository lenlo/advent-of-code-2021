positions = $stdin.readline.split(',').map(&:to_i)

def cheapest(positions)
  (positions.min..positions.max).map {|pos| yield pos}.min
end

# a

def cost_a(positions, target)
  positions.sum {|pos| (target - pos).abs}
end

puts cheapest(positions) {|pos| cost_a(positions, pos)}

# or just use the median:

puts cost_a(positions, positions.sort[positions.length / 2])

# b

def cost_b(positions, target)
  positions.sum {|pos| (1..(target - pos).abs).sum}
end

puts cheapest(positions) {|pos| cost_b(positions, pos)}
