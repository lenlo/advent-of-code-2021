def mark_board(board, number)
  board.each {|row| i = row.index(number); row[i] = nil if i}
end

def check_board(board)
  # none? will return true if all elements are false/nil
  board.any? {|row| row.none?} || board.transpose.any? {|col| col.none?}
end

def score_board(board, number)
  # nil.to_i => 0
  board.sum {|row| row.sum {|x| x.to_i}} * number
end

numbers = $stdin.readline.split(',').map(&:to_i)

# [[<x>, <x>, <x>, <x>, <x>], ...]
board = []
boards = []

for line in $stdin do
  line.strip!
  next if line.empty?

  board <<= line.split(/\s+/).map(&:to_i)
  if board.length == 5 then
    boards <<= board
    board = []
  end
end

for number in numbers do
  boards.each {|board| mark_board(board, number)}

  for winner in boards.find_all {|board| check_board(board)} do
    puts score_board(winner, number)
    boards.delete(winner)
  end
end
