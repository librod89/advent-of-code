## Usage: ruby day-3.rb <path to file>

# to_i26 method taken from https://stackoverflow.com/a/27996169/6061721
class String
  Alpha26 = ("a".."z").to_a

  def to_i26
    result = 0
    downcased = downcase
    (1..length).each do |i|
      char = downcased[-i]
      result += 26**(i-1) * (Alpha26.index(char) + 1)
    end
    result
  end
end

def is_upper?(str)
  str == str.upcase
end

def priority_for_item(item)
  item.to_i26 + (is_upper?(item) ? 26 : 0)
end

def sum_priorities_v1(file)
  sum_priorities = 0

  File.open(file).each do |line|
    rucksack = line.strip
    halfway = rucksack.length / 2
    compartment_1 = rucksack[0...halfway]
    compartment_2 = rucksack[halfway..rucksack.length]
    common = compartment_1.split('') & compartment_2.split('')
    sum_priorities += priority_for_item(common[0])
  end

  sum_priorities
end

def sum_priorities_v2(file)
  group_rucksacks = []
  sum_priorities = 0

  File.open(file).each do |line|
    if group_rucksacks.count < 3
      group_rucksacks.push(line.strip)
    end

    if group_rucksacks.count == 3
      common = group_rucksacks[0].split('') & group_rucksacks[1].split('') & group_rucksacks[2].split('')
      sum_priorities += priority_for_item(common[0])
      group_rucksacks = []
    end
  end

  sum_priorities
end


if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

puts "::::::::::::::::: V1 :::::::::::::::::"
puts sum_priorities_v1(ARGV[0])

puts "::::::::::::::::: V2 :::::::::::::::::"
puts sum_priorities_v2(ARGV[0])
