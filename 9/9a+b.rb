require 'matrix'

# row & column offsets of the neighboring elements
OFFSETS = [[-1, 0], [1, 0], [0, -1], [0, 1]]

def read_map(input)
  lines = input.readlines(chomp: true)
  numbers = lines.join.chars.map(&:to_i)

  return Matrix.build(lines.length, lines[0].length) do |r, c|
    numbers[r * lines[0].length + c]
  end
end

# lookup the element in [r, c] and return it
# or return outside if outside the matrix
def lookup(map, r, c, outside = nil)
  (r >= 0 && r < map.row_count && c >= 0 && c < map.column_count) ?
        map[r, c] : outside
end

# find all the low points and pass them on to the supplied block
def find_low_points(map)
  for r in 0...map.row_count do
    for c in 0...map.column_count do
      height = map[r, c]
      min_adjacent = OFFSETS.map {|dr, dc| lookup(map, r + dr, c + dc, 10)}.min
      yield r, c, height if height < min_adjacent
    end
  end
end

# calculate the basin size at the rc position (= [r, c]) of the map
def basin_size(map, rc, old_points = [])
  return 0 if old_points.include?(rc) or lookup(map, rc[0], rc[1], 9) == 9
  old_points <<= rc
  return 1 + OFFSETS.map {|drdc|
    basin_size(map, [rc, drdc].transpose.map(&:sum), old_points)
  }.sum
end

height_map = read_map($stdin)

# compute risk level
risk_level = 0
find_low_points(height_map) {|r, c, value| risk_level += value + 1}
puts risk_level

# find the basin sizes and multiply the three biggest together
basin_sizes = []
find_low_points(height_map) {|r, c, value|
  basin_sizes <<= basin_size(height_map, [r, c])
}
puts basin_sizes.sort[-3..].inject(1, :*)
