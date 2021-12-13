
# Read the passages as a series of "<x>-<y>" lines and return them in a hash
# table of the form {<x> => [<y>, ...], <y> => [<x>, ...], ...} where each
# room key has as its value the rooms it is connected two (bidirectionally).

def read_map(input)
  map = Hash.new {[]}
  for x, y in input.readlines(chomp: true).map {|line| line.split('-')} do
    map[x] <<= y
    map[y] <<= x
  end
  map
end

def find_paths(map, path, revisited = nil, &block)
  if path[-1] == 'end' then
    yield path
  else
    for room in map[path[-1]] - ['start'] do
      is_big = room =~ /[[:upper:]]/
      been_there = path.include? room

      if is_big or not revisited or not been_there then
        find_paths(map, path + [room],
                   revisited || (!is_big && been_there && room), &block)
      end
    end
  end
end

map = read_map($stdin)
count = 0
find_paths(map, ['start']) {|path| puts path.join('-'); count += 1}
puts "#{count} paths found"
