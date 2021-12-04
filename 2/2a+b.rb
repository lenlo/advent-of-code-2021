hpos = 0
vpos_a = 0
vpos_b = 0 # aka aim

for line in $stdin do
  dir, amt = line.split(' ')
  amt = amt.to_i

  case dir
  when 'forward'
    hpos += amt
    vpos_b += amt * vpos_a
  when 'down'
    vpos_a += amt
  when 'up'
    vpos_a -= amt
  end
end

puts "hpos: #{hpos}"
puts "vpos_a: #{vpos_a}"
puts "h*vpos_a: #{hpos * vpos_a}"

puts "vpos_b: #{vpos_b}"
puts "h*vpos_b: #{hpos * vpos_b}"
