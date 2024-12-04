## Usage: ruby day-4.rb <path to file>
require_relative 'searching'

def build(file)
  @arr = []
  File.open(file).each do |line|
    @arr.push(line.strip.split(''))
  end
end

def run(file)
  build(file)
  @total = 0
  @arr.each_with_index do |_r, row|
    @arr[row].each_with_index do |_c, col|
      letter = @arr[row][col]
      next unless letter == 'A'

      check_diagonal(row, col)
    end

  end
  @total
end

def check_diagonal(row, col)
  if diagonal_up_left(row, col) == 'M'
    return unless diagonal_down_right(row, col) == 'S'
  elsif diagonal_up_left(row, col) == 'S'
    return unless diagonal_down_right(row, col) == 'M'
  else
    return
  end

  if diagonal_up_right(row, col) == 'M'
    return unless diagonal_down_left(row, col) == 'S'
  elsif diagonal_up_right(row, col) == 'S'
    return unless diagonal_down_left(row, col) == 'M'
  else
    return
  end

  @total += 1
end

if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

puts "::::::::::::::::: Part 2 :::::::::::::::::"
puts run(ARGV[0])
