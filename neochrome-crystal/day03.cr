example = [
  "#1 @ 1,3: 4x4",
  "#2 @ 3,1: 4x4",
  "#3 @ 5,5: 2x2",
]

def parse (l)
  id,x1,y1,w,h = l.scan(/#(\d+) @ (\d+),(\d+): (\d+)x(\d+)/)[0].captures.map(&.to_s).map(&.to_i)
  {id,x1,y1,x1+w-1,y1+h-1}
end

squares = File.read_lines("./day03.input").map{|l| parse l}

part1 =
  squares
  .reduce({} of {Int32,Int32} => Int32){ |fab,(_,x1,y1,x2,y2)|
    (y1..y2).each{|y|
      (x1..x2).each{|x|
        fab[{x,y}] = fab.fetch({x,y}, 0) + 1
      }
    }
    fab
  }
  .select{|_,n|n > 1}
  .size
puts "part1: #{part1}"

def intersects (a, b)
  _,ax1,ay1,ax2,ay2 = a
  _,bx1,by1,bx2,by2 = b
  (ax1 >= bx1 && ax1 <= bx2 || bx1 >= ax1 && bx1 <= ax2) && (ay1 >= by1 && ay1 <= by2 || by1 >= ay1 && by1 <= ay2)
end

part2 = squares.find {|a| (squares - [a]).none? {|b| intersects(a, b) }}
unless part2.nil?
  puts "part2: #{part2[0]}"
end
