school = $stdin.read.split(',').map(&:to_i)

# Change representation to an array fish counts indexed by how
# many days there are left until they reproduce.
# - we start with zero fishes reproduction ready
# - tally returns a hash table mapping each element to its frequency.
# - to_a will turn it into an array of [k, v] pairs.
# - we then put the pairs in order and extract their values
# - finally, we zero-pad the array to length 9
school = [0] + school.tally.to_a.sort.map {|a| a[1]}
school += [0] * (9 - school.length)

def age(school, days)
  # Make a copy before we do anything
  school = school.dup
  days.times do |d|
    fishes = school.shift
    school[8] = fishes
    school[6] += fishes
    # puts "# Day #{d + 1}: #{school}"
  end
  school
end

puts "%d fishes" % [age(school, 18).sum]
puts "%d fishes" % [age(school, 80).sum]
puts "%d fishes" % [age(school, 256).sum]

