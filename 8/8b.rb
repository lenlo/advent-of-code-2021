# [[<0>, <1>, ..., <9>, <A>, <B>, <C>, <D>], ...]
codelines = $stdin.readlines(chomp: true).map {|line| line.split(/\W+/)}

# Split each segment string into an sorted array of letters to make them
# easier to process.
codelines.each {|line| line.map! {|code| code.chars.sort}}

# Return an array of codes indexed by the digit they represent
def solve(codes)
  result = Array.new(10)

  # Find the obvious digits
  for dig, len in {1 => 2, 4 => 4, 7 => 3, 8 => 7} do
    result[dig] = codes.find {|code| code.length == len}
  end

  # Count how often each segment occurs in all the digits
  freq = codes.flatten.tally

  # The a segment exists in 7, but not in 1
  a = (result[7] - result[1]).first
  # The b segment is the only one occurring in exactly 6 digits
  b = freq.find {|k, v| v == 6}.first
  # The f segment is the only one occurring in exactly 4 digits
  e = freq.find {|k, v| v == 4}.first
  # The f segment is the only one occurring in exactly 9 digits
  f = freq.find {|k, v| v == 9}.first
  # The c segment is the remainder when you remove a and f from 7
  c = (result[7] - [a, f]).first
  # The d and g segments are the only ones occurring in exactly 7 digits
  dg = freq.select {|k, v| v == 7}.map {|pair| pair[0]}
  # However, d is the only one that exists in 4
  d = (result[4] & dg).first
  g = (dg - [d]).first

  result[0] = [a, b, c, e, f, g].sort
  result[2] = [a, c, d, e, g].sort
  result[3] = [a, c, d, f, g].sort
  result[5] = [a, b, d, f, g].sort
  result[6] = [a, b, d, e, f, g].sort
  result[9] = [a, b, c, d, f, g].sort

  return result
end

def decode(keys, codes)
  result = 0
  for code in codes do
    result = result * 10 + keys.index(code)
  end
  # puts result
  return result
end

puts codelines.sum {|line| decode(solve(line[0..9]), line[10..])}
