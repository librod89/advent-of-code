## Usage: ruby day-11.rb <path to file>

def build(file)
  @stones
  File.open(file).each do |line|
    @stones = line.strip.split(' ').map(&:to_i)
  end
end

def run(num)
  num.times do |num|
    new_stones = []
    @stones.each do |stone|
      if stone == 0
        new_stones.push(1)
      elsif stone.to_s.length.even?
        stone_str = stone.to_s
        half = stone_str.length / 2

        new_stones.push(stone_str[0...half].to_i, stone_str[half..].to_i)
      else
        new_stones.push(stone * 2024)
      end
    end

    @stones = new_stones
    # puts "at #{num} there are #{@stones.count} stones"
    # puts "#{"#" * Math.log(@stones.count).to_i}"
  end

  @stones.count
end

if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

build(ARGV[0])

puts "::::::::::::::::: Part 1 :::::::::::::::::"
puts run(25)

# puts "::::::::::::::::: Part 2 :::::::::::::::::"
# puts run(75)
# Scott and I worked on this part together
