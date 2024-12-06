## Usage: ruby day-6.rb <path to file>
require_relative 'searching'

DIRECTIONS = {
  UP: '^',
  DOWN: 'V',
  LEFT: '<',
  RIGHT: '>'
}

OBSTACLE = '#'
MARK_IT = 'X'
EMPTY_SPACE = '.'

def build(file)
  @map = []
  i = 0
  File.open(file).each do |line|
    arr = line.strip.split('')
    @map.push(arr)
    @guard_col = look_for_starting_position(arr)&.last if @guard_col.nil?
    @guard_row = i if !@guard_col.nil? && @guard_row.nil?
    i += 1
  end

  @starting_map = create_deep_copy
  @starting_row = @guard_row
  @starting_col = @guard_col
end

def look_for_starting_position(line)
  line.each_with_index.find do |e, i|
    DIRECTIONS.values.include?(e)
  end
end

def create_deep_copy(map = @map)
  new_arr = []
  map.each do |row|
    new_arr.push(row.clone)
  end
  new_arr
end

def run
  @started_moving = false
  @positions = create_deep_copy
  @starting_spots = {}
  @positions[@guard_row][@guard_col] = MARK_IT

  while @guard_row != -1 && @guard_col != -1 do
    if @started_moving && @starting_spots["#{@guard_row},#{@guard_col},#{@map[@guard_row][@guard_col]}"]
      @loops += 1
      break
    end

    @started_moving = true
    @stopped = false
    direction_to_go = @map[@guard_row][@guard_col].dup
    @map[@guard_row][@guard_col] = EMPTY_SPACE
    @starting_spots["#{@guard_row},#{@guard_col},#{direction_to_go}"] = true

    case direction_to_go
    when DIRECTIONS[:UP]
      move_up
    when DIRECTIONS[:DOWN]
      move_down
    when DIRECTIONS[:LEFT]
      move_left
    when DIRECTIONS[:RIGHT]
      move_right
    else
      puts "SOMETHING WENT WRONG! #{direction_to_go}"
      exit 0
    end
  end

  tally_marks
end

def add_obstruction
  @loops = 0

  @starting_map.each_with_index do |_r, row|
    @starting_map[row].each_with_index do |_c, col|
      next if @starting_map[row][col] == OBSTACLE
      next if row == @starting_row && col == @starting_col

      @map = create_deep_copy(@starting_map)
      @guard_row = @starting_row
      @guard_col = @starting_col

      @map[row][col] = OBSTACLE
      run
    end
    puts "checking row #{row}"
  end

  @loops
end

def tally_marks
  @positions.reduce(0) do |total, row|
    total + (row.tally[MARK_IT] || 0)
  end
end

if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

build(ARGV[0])
puts "::::::::::::::::: Part 1 :::::::::::::::::"
puts run

puts "::::::::::::::::: Part 2 :::::::::::::::::"
puts add_obstruction
