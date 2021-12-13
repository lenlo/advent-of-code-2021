def read_data(input)
  points = []
  instructions = []

  for line in input do
    if line =~ /(\d+),(\d+)/ then
      points <<= [$1.to_i, $2.to_i]
    elsif line =~ /fold along (.)=(\d+)/ then
      instructions <<= [$1, $2.to_i]
    end
  end

  return [points, instructions]
end

def execute(points, max, instructions)
  for axis, line in instructions do
    case axis
    when 'x'
      points = points.map {|x, y|
        x > line ? [max[0] - x, y] : [x, y]
      }.uniq
      max = [line - 1, max[1]]
    when 'y'
      points = points.map {|x, y|
        y > line ? [x, max[1] - y] : [x, y]
      }.uniq
      max = [max[0], line - 1]
    end
  end

  return points, max
end

def show_paper(points, max)
  (0..max[1]).each do |y|
    (0..max[0]).each do |x|
      print points.include?([x, y]) ? '#' : '.'
    end
    puts
  end
end

points, instructions = read_data($stdin)
max = points.transpose.map(&:max)

result, _ = execute(points, max, [instructions.first])
puts "#{result.length} points after first instruction"

puts

result, final_max = execute(points, max, instructions)
show_paper(result, final_max)
