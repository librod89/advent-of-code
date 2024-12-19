## Usage: ruby day-15.rb <path to file>
require_relative 'moving'

def replacements(row)
  new_row = []
  row.map do |r|
    if r == WALL
      new_row.push(WALL)
      new_row.push(WALL)
    elsif r == OLD_BOX
      new_row.push('[')
      new_row.push(']')
    elsif r == EMPTY
      new_row.push(EMPTY)
      new_row.push(EMPTY)
    elsif r == ROBOT
      new_row.push(ROBOT)
      new_row.push(EMPTY)
    end
  end
  new_row
end

def build(file)
  @map, @moves = [], []
  @robot_x, @robot_y = nil, nil
  iter = 0
  map_complete = false
  File.open(file).each do |line|
    map_complete = true if line.strip.empty?
    row = line.strip.split('')
    if map_complete
      @moves = @moves.concat(row)
    else
      row = replacements(row)
      if row.include?(ROBOT)
        @robot_x = iter
        @robot_y = row.find_index(ROBOT)
      end
      @map.push(row)
    end
    iter += 1
  end
end

def count_box_coordinates
  total = 0
  @map.each_with_index do |_r, row|
    @map[row].each_with_index do |_c, col|
      next unless @map[row][col] == BOX_LEFT

      total += (100 * row + col)
    end
  end
  total
end

def run
  @moves.each do |direction|
    # puts "moving #{direction}"
    case direction
    when LEFT
      move(@robot_x, @robot_y - 1, LEFT)
    when RIGHT
      move(@robot_x, @robot_y + 1, RIGHT)
    when UP
      move(@robot_x - 1, @robot_y, UP)
    when DOWN
      move(@robot_x + 1, @robot_y, DOWN)
    else
      puts "DIDN'T FIND WHAT YOU EXPECTED IN DIRECTION #{direction}"
    end
    # display_map
  end
  count_box_coordinates
end

def display_map
  @map.each_with_index do |_r, row|
    puts "#{@map[row]}"
  end
  true
end

if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

build(ARGV[0])

puts "::::::::::::::::: Part 2 :::::::::::::::::"
puts run
