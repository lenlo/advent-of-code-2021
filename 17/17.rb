def run(vx, vy, tx, ty)
  x = 0
  y = 0
  ymax = y
  while true do
    x += vx
    y += vy

    ymax = y if y > ymax

    return ymax if tx.include? x and ty.include? y
    return false if x > tx.max or y < ty.min

    vx = [vx - 1, 0].max
    vy -= 1
  end
end

raise "illegal input" unless
  readline =~ /x=(-?\d+)..(-?\d+), y=(-?\d+)..(-?\d+)/

tx = ($1.to_i..$2.to_i)
ty = ($3.to_i..$4.to_i)

# Stupid brute force
ymax = 0
hits = 0
1000.times do |vx|
  (-1000..1000).each do |vy|
    ym = run(vx, vy, tx, ty)
    # puts "# Hit target with #{vx},#{vy} => #{ym}\n" if ym
    ymax = ym if ym and ym > ymax
    hits += 1 if ym
  end
end

puts "Max y=#{ymax}"
puts "Hits: #{hits}"
