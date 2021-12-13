
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

def find_paths(map, path, &block)
  if path[-1] == 'end' then
    yield path
  else
    for room in map[path[-1]] do
      if room =~ /[[:upper:]]/ or not path.include? room then
        find_paths(map, path + [room], &block)
      end
    end
  end
end

map = read_map($stdin)
count = 0
find_paths(map, ['start']) {|path| puts path.join('-'); count += 1}
puts "#{count} paths found"
