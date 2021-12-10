# [[<0>, <1>, ..., <9>, <A>, <B>, <C>, <D>], ...]
codelines = $stdin.readlines(chomp: true).map {|line| line.split(/\W+/)}

# The segment lengths of digits 1, 4, 7, 8
lengths_1478 = [2, 4, 3, 7]

puts codelines.sum {|codes|
  lengths_1478.sum {|len| codes[-4..].count {|code| code.length == len}}
}
