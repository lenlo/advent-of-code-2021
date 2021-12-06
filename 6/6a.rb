#!/usr/bin/env ruby

school = $stdin.read.split(',').map(&:to_i)

def age(school, days)
  days.times do |d|
    school += [9] * school.count {|fish| fish == 0}
    school = school.map {|fish| fish == 0 ? 6 : fish - 1}
    # puts "After #{d + 1} days: #{school.join(',')}"
  end
  school
end

puts "%d fishes" % [age(school, 18).length]
puts "%d fishes" % [age(school, 80).length]

