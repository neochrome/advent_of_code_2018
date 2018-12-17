require "./lib.cr"

freqs = File.read_lines("./day02.input").map(&.freqs)
twos = freqs.select(&.has_value? 2).size
threes = freqs.select(&.has_value? 3).size
puts "part1: #{twos * threes}"

def diff (a, b)
  where = nil
  a.each_char_with_index { |c,i|
    if b[i] != c
      return nil unless where.nil?
      where = i
    end
  }
  where
end

File.read_lines("./day02.input")
.each_combination 2 do |(s1,s2)|
  at = diff(s1, s2)
  unless at.nil?
    puts "part2: #{s1.delete at}"
    break
  end
end
