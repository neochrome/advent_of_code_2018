changes = File.read_lines("./day01.input").map(&.to_i)

puts "part1: #{changes.sum}"

seen = Set(Int32).new
freq = 0
changes.cycle do |c|
  freq += c
  break if seen.includes? freq
  seen.add freq
end
puts "part2: #{freq}"
