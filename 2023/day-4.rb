## Usage: ruby day-4.rb <path to file>

def run_v1(file)
  total = 0
  File.open(file).each do |line|
    points = 0
    winning_nums, nums_you_have = parse_card(line)
    winning_nums.each do |num|
      if nums_you_have.include?(num)
        points = (points === 0 ? 1 : points * 2)
      end
    end
    total += points
  end
  total
end

@cards = {}
@copies = []
@answers = {}

def run_v2(file)
  card = 1
  File.open(file).each do |line|
    @cards[card] = line
    @copies.push(card)
    card += 1
  end

  total = 0
  @copies.each do |key|
    unless @answers[key]
      matching_nums = 0
      winning_nums, nums_you_have = parse_card(@cards[key])
      winning_nums.each do |num|
        matching_nums += 1 if nums_you_have.include?(num)
      end
      @answers[key] = matching_nums
    end
    card_num = key
    while card_num < key + @answers[key] do
      @copies.push(card_num + 1)
      card_num += 1
    end
    total += 1
  end
  total
end

def parse_card(line)
  # Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
  card = line.split("|")
  return card[0].split(":")[1].strip.split(" "), card[1].strip.split(" ")
end

if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

puts "::::::::::::::::: Part 1 :::::::::::::::::"
puts run_v1(ARGV[0])

puts "::::::::::::::::: Part 2 :::::::::::::::::"
puts run_v2(ARGV[0])
