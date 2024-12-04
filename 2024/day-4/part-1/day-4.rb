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
      next unless letter == 'X'

      check_horizontal(row, col)
      check_vertical(row, col)
      check_diagonal(row, col)
    end

  end
  @total
end

def check_horizontal(row, col)
  forwards(row, col)
  backwards(row, col)
end

def check_vertical(row, col)
  up(row, col)
  down(row, col)
end

def check_diagonal(row, col)
  diagonal_up_left(row, col)
  diagonal_down_left(row, col)
  diagonal_up_right(row, col)
  diagonal_down_right(row, col)
end

if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

puts "::::::::::::::::: Part 1 :::::::::::::::::"
puts run(ARGV[0])
