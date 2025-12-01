## Usage: ruby day-1.rb <path to file>

def find_password(file, move_version = "move_v1")
  current = 50
  @password = 0
  File.open(file).each do |line|
    break if line.empty?

    direction = line[0]
    number = line[1..].to_i
    current = send(move_version, current, direction, number)
  end

  @password
end

def move_v1(current, direction, number)
  case direction
  when "L"
    current -= number
  when "R"
    current += number
  end

  current = current % 100 if current < 0 || current > 99
  @password += 1 if current == 0
  current
end

def move_v2(current, direction, number)
  original_number = current
  case direction
  when "L"
    current -= number
  when "R"
    current += number
  end

  normalize(original_number, current)
end

def normalize(original_number, number)
  while number < 0
    number += 100
    @password += 1 unless original_number == 0
    original_number = number
  end

  if number == 0
    @password += 1
  end

  while number > 99
    number -= 100
    @password += 1
  end

  number
end

if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

puts "::::::::::::::::: Part 1 :::::::::::::::::"
puts find_password(ARGV[0])

puts "::::::::::::::::: Part 2 :::::::::::::::::"
puts find_password(ARGV[0], "move_v2")
