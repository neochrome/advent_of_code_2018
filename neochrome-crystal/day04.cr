struct Guard
  property id

  def initialize(@id : Int32)
    @sleeps = Hash(Int32,Int32).new
  end

  def sleep(minute)
    @sleeps[minute] = @sleeps.fetch(minute, 0) + 1
  end

  def sleep?(minute)
    @sleeps.fetch(minute, 0)
  end

  def total_sleep()
    @sleeps.values.sum
  end

  def most_asleep()
    m,_ = @sleeps.max_by{|(_,n)|n}
    m
  end
end

guards = File.read_lines("./day04.input")
.sort
.reduce({Hash(Int32,Guard).new, nil, nil}){|(guards,guard,start),line|
  m = line.scan(/:(\d\d)\] (wakes|falls|Guard #(\d+))/).first
  case {m[2],guard,start}
  when {"falls",_,_}
    start = m[1].to_i
  when {"wakes",Guard,Int32}
    (start...m[1].to_i).each{|m|guard.sleep(m)}
    start = nil
  else
    id = m[3].to_i
    if guards[id]?
      guard = guards[id]
    else
      guard = Guard.new id
      guards[id] = guard
    end
    start = nil
  end
  {guards,guard,start}
}[0].values

g1 = guards.max_by{|g|g.total_sleep}
puts "part1: #{g1.id * g1.most_asleep}"

m2,g2,_ =(0..59).map{|m|
  g = guards.max_by{|g|g.sleep?(m)}
  {m,g.id,g.sleep?(m)}
}.max_by{|(_,_,n)|n}
puts "part2: #{m2 * g2}"
