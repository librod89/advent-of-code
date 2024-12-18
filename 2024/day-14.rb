## Usage: ruby day-14.rb <path to file>

WIDTH = 101
HEIGHT = 103
EMPTY = '.'

def build(file)
  @positions = []
  @velocities = []
  File.open(file).each do |line|
    position, velocity = line.strip.split(' ')
    x, y = position[2..].split(',').map(&:to_i)
    @positions.push({ x: x, y: y })

    x, y = velocity[2..].split(',').map(&:to_i)
    @velocities.push({ x: x, y: y })
  end
end

def move
  @positions.each_with_index do |position, index|
    x, y = position[:x], position[:y]
    new_x = x + @velocities[index][:x]
    new_y = y + @velocities[index][:y]

    if new_x < 0
      new_x = WIDTH - new_x.abs
    elsif new_x >= WIDTH
      new_x = new_x - WIDTH
    end

    if new_y < 0
      new_y = HEIGHT - new_y.abs
    elsif new_y >= HEIGHT
      new_y = new_y - HEIGHT
    end

    position[:x] = new_x
    position[:y] = new_y
  end
end

def count_robots
  width_middle = WIDTH / 2
  height_middle = HEIGHT / 2

  top_left_quadrant = 0
  top_right_quadrant = 0
  bottom_right_quadrant = 0
  bottom_left_quadrant = 0
  @positions.each do |position|
    if position[:x] < width_middle && position[:y] < height_middle
      top_left_quadrant += 1
    elsif position[:x] > width_middle && position[:y] < height_middle
      top_right_quadrant += 1
    elsif position[:x] < width_middle && position[:y] > height_middle
      bottom_left_quadrant += 1
    elsif position[:x] > width_middle && position[:y] > height_middle
      bottom_right_quadrant += 1
    end
  end
  top_left_quadrant * top_right_quadrant * bottom_left_quadrant * bottom_right_quadrant
end

def draw_map(iter)
  map = Array.new(HEIGHT) { EMPTY }
  map.each_with_index do |_r, row|
    map[row] = Array.new(WIDTH) { EMPTY }
  end

  @positions.each do |position|
    x, y = position[:x], position[:y]

    map[y][x] = 0 if map[y][x] == EMPTY
    map[y][x] += 1
  end

  File.open("day-14-log.txt", 'a') do |file|
    map.each_with_index do |_r, row|
      file.write(map[row].map(&:to_s))
      file.write("\n")
    end
  end
end

def run_v1
  100.times { move }
  count_robots
end

def run_v2
  @minimal_safety_factor = 218295000
  iter = 1
  while true do
    move

    safety_factor = count_robots
    if safety_factor < @minimal_safety_factor
      @minimal_safety_factor = safety_factor
      puts "found safety factor #{safety_factor} at #{iter}"
      draw_map(iter)
    end
    iter += 1
  end
end

if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

build(ARGV[0])

puts "::::::::::::::::: Part 1 :::::::::::::::::"
puts run_v1

puts "::::::::::::::::: Part 2 :::::::::::::::::"
puts run_v2
