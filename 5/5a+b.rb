# [[x1, y1, x2, y2], ...]
lines = $stdin.map {|line| line =~ /(\d+),(\d+) -> (\d+),(\d+)/ &&
                    $~[1..].map(&:to_i)}

DIM = 1000

def draw_line(board, diag_ok, x1, y1, x2, y2)
  if x1 == x2 then
    ([y1, y2].min..[y1, y2].max).each {|y| board[x1 + y * DIM] += 1}
  elsif y1 == y2 then
    ([x1, x2].min..[x1, x2].max).each {|x| board[x + y1 * DIM] += 1}
  elsif diag_ok then
    x_step = x1 < x2 ? 1 : -1
    y_step = y1 < y2 ? 1 : -1
    while true do
      board[x1 + y1 * DIM] += 1
      break if x1 == x2 and y1 == y2
      x1 += x_step
      y1 += y_step
    end
  end
end

# 4a

board = Array.new(DIM * DIM) {0}
lines.each {|line| draw_line(board, false, *line)}
puts board.count {|a| a > 1}

# 4b

board = Array.new(DIM * DIM) {0}
lines.each {|line| draw_line(board, true, *line)}
puts board.count {|a| a > 1}
