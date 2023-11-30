## Usage: ruby day-1.rb <path to file>

@calories_per_elf = {}

def parse_file(file)
  elves = 0
  calories = 0
  File.open(file).each do |line|
    if line.strip.empty?
      @calories_per_elf[elves] = calories
      elves += 1
      calories = 0
      next
    end

    calories += line.to_i
  end
end

def remove_from_hash_by_value(val)
  key = @calories_per_elf.key(val)
  @calories_per_elf.delete(key)
end

def find_max
  @calories_per_elf.max_by { |h, v| v }.last
end

def find_top_three_max
  max_1 = find_max
  remove_from_hash_by_value(max_1)

  max_2 = find_max
  remove_from_hash_by_value(max_2)

  max_3 = find_max
  remove_from_hash_by_value(max_3)

  max_1 + max_2 + max_3
end

if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

parse_file(ARGV[0])

puts ":::::::::::::::::MAX:::::::::::::::::"
puts find_max

puts ":::::::::::::::TOP 3 MAX:::::::::::"
puts find_top_three_max
