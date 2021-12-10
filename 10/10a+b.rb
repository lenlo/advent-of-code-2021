OPENERS = '([{<'
CLOSERS = ')]}>'
SYNTAX_POINTS = [3, 57, 1197, 25137]

def validate(line)
  stack = []
  for char in line.chars do
    i = OPENERS.index(char)
    if i then
      stack.push(CLOSERS[i])
    elsif char != stack.pop then
      return yield char, stack
    end
  end
  return yield nil, stack
end

lines = $stdin.readlines(chomp: true)

# 10a

puts lines.sum {|line|
  validate(line) {|char, stack|
    char ? SYNTAX_POINTS[CLOSERS.index(char)] : 0
  }
}

# 10b

scores = []
lines.each {|line|
  validate(line) {|char, stack|
    unless char then
      total = 0
      while not stack.empty? do
        total = total * 5 + CLOSERS.index(stack.pop) + 1
      end
      scores <<= total
    end
  }
}
puts scores.sort[scores.length / 2]
