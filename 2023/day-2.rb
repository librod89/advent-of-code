## Usage: ruby day-2.rb <path to file>

CUBES = {
  'red' => 12,
  'green' => 13,
  'blue' => 14
}.freeze

def run_v1(file)
  total = 0
  File.open(file).each do |line|
    impossible = false
    game, sets = line.split(':')          # Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
    game_num = game.split(' ')[1].to_i    # Game 1
    subsets = sets.strip.split(';')       # 3 blue, 4 red;
    subsets.each do |set|
      cubes = set.split(',')              # 3 blue
      cubes.each do |cube|
        num, color = cube.split(' ')
        if num.to_i > CUBES[color]
          impossible = true
          break
        end
      end
      break if impossible
    end
    total += game_num unless impossible
  end
  total
end

def run_v2(file)
  total = 0
  File.open(file).each do |line|
    max_cubes = { 'red' => 0, 'green' => 0, 'blue' => 0 }
    game, sets = line.split(':')          # Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
    game_num = game.split(' ')[1].to_i    # Game 1
    subsets = sets.strip.split(';')       # 3 blue, 4 red;
    subsets.each do |set|
      cubes = set.split(',')              # 3 blue
      cubes.each do |cube|
        num, color = cube.split(' ')
        max_cubes[color] = num.to_i if num.to_i > max_cubes[color]
      end
    end
    total += max_cubes.values.inject(&:*)
  end
  total
end

if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

puts "::::::::::::::::: Part 1 :::::::::::::::::"
puts run_v1(ARGV[0])

puts "::::::::::::::::: Part 2 :::::::::::::::::"
puts run_v2(ARGV[0])
