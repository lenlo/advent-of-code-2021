# Read puzzle as the start string + a hash table of rules,
# each one being <pair> => <middle>.

def read_puzzle(input)
  start = input.readline.chomp
  rules = input.readlines.filter_map {|line|
    line =~ /(..) -> (.)/ && [$1, $2]
  }.to_h

  return start, rules
end

# Perform each step of the polymer expansion producing
# a new polymer string each time.

def step(poly, rules)
  poly.length.times.map {|i|
    i == 0 ? poly[0] : rules[poly[i-1..i]].to_s + poly[i]
  }.join
end

# ---

poly, rules = read_puzzle($stdin)

10.times {poly = step(poly, rules)}

freq = poly.chars.tally
min_elem, min_count = freq.min_by {|k, v| v}
max_elem, max_count = freq.max_by {|k, v| v}

puts "After 10 steps:"
puts "#{min_elem} occurs #{min_count} and is the least common"
puts "#{max_elem} occurs #{max_count} and is the most common"
puts "The difference is #{max_count - min_count}"
