## Usage: ruby day-1.rb <path to file>

def run_v1(file)
  sum = 0
  File.open(file).each do |line|
    bank = line.strip.split('')
    sum += highest_joltage(bank)
  end
  sum
end

def highest_joltage(bank)
  highest = -1
  bank.each_with_index do |first, i|
    bank[i+1..].each do |last|
      joltage = "#{first}#{last}".to_i
      if joltage > highest
        highest = joltage
      end
    end
  end
  highest
end

def run_v2(file)
  sum = 0
  File.open(file).each do |line|
    bank = line.strip.split('')
    sum += highest_joltage_v2(bank)
  end
  sum
end

# Looking at this visualization was a huge help
# https://www.reddit.com/r/adventofcode/comments/1pd0cp6/2025_day_03_cli_visualization/
def highest_joltage_v2(bank)
  final_joltage = ""
  remaining = 12
  s = 0
  e = bank.length - remaining

  while s < e && e < bank.length do
    # Find highest in this range
    highest = -1
    index = -1
    bank[s..e].each_with_index do |num, i|
      joltage = num.to_i
      if joltage > highest
        highest = joltage
        index = s+i
      end
    end

    final_joltage += bank[index]
    remaining -= 1
    s = index + 1
    e = bank.length - remaining
  end

  final_joltage += bank[e..].join('')
  final_joltage.to_i
end

if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

puts "::::::::::::::::: Part 1 :::::::::::::::::"
puts run_v1(ARGV[0])

puts "::::::::::::::::: Part 2 :::::::::::::::::"
puts run_v2(ARGV[0])
