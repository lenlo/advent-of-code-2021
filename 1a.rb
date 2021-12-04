count = 0
last = 99999

for line in $stdin do
  this = line.to_i
  count += 1 if this > last
  last = this
end

puts count
