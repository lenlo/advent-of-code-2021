def most_common(lines, index)
  ones = lines.sum {|line| line[index]}
  return 2 * ones / lines.length
end

lines = $stdin.readlines.map {|line| line.strip.chars.map(&:to_i)}

oxy_lines = lines.dup
co2_lines = lines.dup

bits = lines[0].length

for i in 0...bits do
  if oxy_lines.length > 1 then
    oxy_mc = most_common(oxy_lines, i)
    oxy_lines.select! {|line| line[i] == oxy_mc}
  end

  if co2_lines.length > 1 then
    co2_mc = most_common(co2_lines, i)
    co2_lines.select! {|line| line[i] != co2_mc}
  end
end

oxy = oxy_lines[0].join.to_i(2)
co2 = co2_lines[0].join.to_i(2)

puts "oxy: #{oxy} #{oxy_lines}"
puts "co2: #{co2} #{co2_lines}"

puts oxy * co2
