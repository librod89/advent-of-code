## Usage: ruby day-5.rb <path to file>

def initialize_arrangement
  @arrangement = {}
  (1..9).each do |num|
    @arrangement[num] = []
  end
end

def build(line)
  col = 0
  index = 1

  while col < line.length do
    col += 1  # get to the center of the stack
    if line[col] != " "
      @arrangement[index].push(line[col])
    end
    col += 3  # proceed to the next stack
    index += 1
  end
end

def rearrange_v1(line)
  directions = line.scan(/\d+/)
  return if directions.empty?

  movement = directions[0].to_i
  origin = directions[1].to_i
  dest = directions[2].to_i

  while movement > 0 do
    @arrangement[dest].unshift(@arrangement[origin].shift)
    movement -= 1
  end
end

def rearrange_v2(line)
  directions = line.scan(/\d+/)
  return if directions.empty?

  movement = directions[0].to_i
  origin = directions[1].to_i
  dest = directions[2].to_i

  @arrangement[dest].unshift(@arrangement[origin].slice!(0, movement)).flatten!
end

def concat_each_first
  sum = ""
  (1..9).each do |num|
    sum += @arrangement[num][0]
  end
  sum
end

def run(file, rearrange)
  initialize_arrangement
  building = true

  File.open(file).each do |line|
    if line[1] == "1"
      building = false
      next
    end

    building ? build(line) : rearrange.call(line)
  end

  puts concat_each_first
end

if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

puts "::::::::::::::::: V1 :::::::::::::::::"
run(ARGV[0], method(:rearrange_v1))

puts "::::::::::::::::: V2 :::::::::::::::::"
run(ARGV[0], method(:rearrange_v2))
