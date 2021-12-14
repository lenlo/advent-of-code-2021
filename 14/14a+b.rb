# Read puzzle as the start string + a hash table of rules,
# each one being <pair> => <middle>.

def read_puzzle(input)
  start = input.readline.chomp
  rules = input.readlines.filter_map {|line|
    line =~ /(..) -> (.)/ && [$1, $2]
  }.to_h

  return start, rules
end

# Count the number of pairs in the polymer string and return
# a hash table of pair counts.
#
# For example:
#   count_pairs("ABABAC") => {"AB" => 2, "BA" => 2, "AC" => 1}
#

def count_pairs(poly_string)
  poly_pairs = Hash.new {0}
  poly_string.chars.each_cons(2) {|pair| poly_pairs[pair.join] += 1}
  poly_pairs
end

# Count the number of times each element would be present in
# the polymer string that the pair_counts represent.
#
# For example:
#   count_elements({"AB" => 2, "BA" => 2, "AC" => 1}, "ABABAC") =>
#     {"A" => 3, "B" => 2, "C" => 1}

def count_elements(pair_counts, pair_string)
  element_counts = Hash.new {0}
  pair_counts.each {|pair, count|
    element_counts[pair[0]] += count
    element_counts[pair[1]] += count
  }
  # Since we're counting overlapping pairs, each element will be counted
  # twice, so we need to divide by two to the get true count. But first we
  # need to add the first and last elements as they've only been counted
  # once.
  element_counts[pair_string[0]] += 1
  element_counts[pair_string[-1]] += 1
  element_counts.map {|element, count| [element, count / 2]}.to_h
end

# Perform each step of the polymer expansion, counting the
# resulting pairs in the process and returning the new counts.

def step(pair_counts, rules)
  new_counts = Hash.new {0}
  pair_counts.to_a.each do |pair, count|
    middle = rules[pair]
    new_counts[[pair[0], middle].join] += count
    new_counts[[middle, pair[1]].join] += count
  end
  new_counts
end

# ---

poly, rules = read_puzzle($stdin)
pair_counts = count_pairs(poly)

10.times {pair_counts = step(pair_counts, rules)}

element_counts = count_elements(pair_counts, poly)
min_elem, min_count = element_counts.min_by {|k, v| v}
max_elem, max_count = element_counts.max_by {|k, v| v}

puts "After 10 steps:"
puts "#{min_elem} occurs #{min_count} and is the least common"
puts "#{max_elem} occurs #{max_count} and is the most common"
puts "The difference is #{max_count - min_count}"

30.times {pair_counts = step(pair_counts, rules)}

element_counts = count_elements(pair_counts, poly)
min_elem, min_count = element_counts.min_by {|k, v| v}
max_elem, max_count = element_counts.max_by {|k, v| v}

puts
puts "After 40 steps:"
puts "#{min_elem} occurs #{min_count} and is the least common"
puts "#{max_elem} occurs #{max_count} and is the most common"
puts "The difference is #{max_count - min_count}"

