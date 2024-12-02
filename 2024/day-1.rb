## Usage: ruby day-1.rb <path to file>

def build(file)
  left = []
  right = []
  File.open(file).each do |line|
    numbers = line.split(' ')
    left.push(numbers.first.to_i)
    right.push(numbers.last.to_i)
  end

  return left.sort!, right.sort!
end

def run_v1(file)
  left, right = build(file)
  distance = 0
  left.each_with_index do |l, i|
    distance += (l - right[i]).abs
  end

  distance
end

def run_v2(file)
  left, right = build(file)
  right_tally = right.tally
  left.reduce(0) do |total, l|
    next total unless right_tally[l]

    total + (l * right_tally[l])
  end
end

if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

puts "::::::::::::::::: Part 1 :::::::::::::::::"
puts run_v1(ARGV[0])

puts "::::::::::::::::: Part 2 :::::::::::::::::"
puts run_v2(ARGV[0])
