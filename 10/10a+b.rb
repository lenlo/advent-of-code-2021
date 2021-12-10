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

scores = lines.filter_map {|line|
  validate(line) {|char, stack|
    # Completion points are 1 + the char's index in CLOSERS
    char ? nil : stack.reverse.map {|char| CLOSERS.index(char) + 1}.join.to_i(5)
  }
}

puts scores.sort[scores.length / 2]
