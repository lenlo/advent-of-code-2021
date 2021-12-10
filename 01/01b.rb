count = 0
last = [readline.to_i, readline.to_i, readline.to_i]

for line in $stdin do
  this = last[1..] + [line.to_i]
  count += 1 if this.sum > last.sum
  last = this
end

puts count
