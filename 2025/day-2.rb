## Usage: ruby day-1.rb <path to file>

def run(file, version = "v1")
  @sum = 0
  File.open(file).each do |line|
    @ranges = line.strip.split(',')
  end

  @ranges.each do |range|
    find_invalid_ids(range, version)
  end

  @sum
end

def find_invalid_ids(range, version)
  first, last = range.split('-').map(&:to_i)

  while first <= last do
    @sum += first if version == "v1" ? invalid_v1?(first.to_s) : invalid_v2?(first.to_s)
    first += 1
  end
end

def invalid_v1?(number)
  halfway = number.length / 2

  number[0...halfway] == number[halfway..]
end

def invalid_v2?(number)
  halfway = number.length / 2

  while halfway > 0 do
    return true if number.split(number[0...halfway]).empty?

    halfway -= 1
  end
end

if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

puts "::::::::::::::::: Part 1 :::::::::::::::::"
puts run(ARGV[0])

puts "::::::::::::::::: Part 2 :::::::::::::::::"
puts run(ARGV[0], "v2")
