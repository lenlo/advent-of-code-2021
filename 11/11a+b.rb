require 'matrix'

# Collect neighboring offsets
OFFSETS = 9.times.map {|a| [a / 3 - 1, a % 3 - 1]} - [[0, 0]]

def read_matrix(input)
  lines = input.readlines(chomp: true)
  numbers = lines.join.chars.map(&:to_i)

  return Matrix.build(lines.length, lines[0].length) do |r, c|
    numbers[r * lines[0].length + c]
  end
end

def inc(matrix, r, c)
  if r >= 0 && r < matrix.row_count && c >= 0 && c < matrix.column_count then
    # Incrememnt this dumbo and all of its neighbors too if it flashes
    if (matrix[r, c] += 1) == 10 then
      OFFSETS.each {|dr, dc| inc(matrix, r + dr, c + dc)}
    end
  end
end

def step(matrix)
  # Increment each dumbo's energy while handling flashes
  matrix.each_with_index {|x, r, c| inc(matrix, r, c)}
  # Reset those who flashed
  matrix.map! {|x| x > 9 ? 0 : x}
  # Count flashes
  matrix.count {|x| x == 0}
end

dumbos = read_matrix($stdin)

# Count the number of flashes during the first 100 steps
puts 100.times.sum {step(dumbos)}

# Find the first time all dumbos flash at the same time
# (after the first 100 steps; yeah, I know this is a bit cheeky).
# Note: The extra 1 in 101 is because times' iterator is zero-based.
puts 101 + 1000.times.find {step(dumbos) == dumbos.count}



