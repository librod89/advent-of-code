## Usage: ruby day-10.rb <path to file>

LOWEST_HEIGHT = 0
HIGHEST_HEIGHT = 9

def build(file)
  @map = []
  File.open(file).each do |line|
    @map.push(line.strip.split('').map(&:to_i))
  end
end

def run(find_rating = false)
  @find_rating = find_rating
  @trails = {}
  @map.each_with_index do |_r, row|
    @map[row].each_with_index do |_c, col|
      next unless @map[row][col] == LOWEST_HEIGHT

      find_trail("#{row},#{col}", row, col)
    end
  end
  return @trails.values.sum if @find_rating

  @trails.values.map(&:values).flatten.sum
end

def find_trail(trailhead, row, col)
  current_height = @map[row][col]
  next_height = current_height + 1

  if current_height == HIGHEST_HEIGHT
    if @find_rating
      # rating
      @trails[trailhead] ||= 0
      @trails[trailhead] += 1
    else
      # score
      @trails[trailhead] ||= {}
      @trails[trailhead]["#{row},#{col}"] = 1
    end
    return
  end

  # Look up
  find_trail(trailhead, row-1, col) if row - 1 >= 0 && @map[row-1][col] == next_height
  # Look down
  find_trail(trailhead, row+1, col) if row + 1 < @map.length && @map[row+1][col] == next_height
  # Look left
  find_trail(trailhead, row, col-1) if col - 1 >= 0 && @map[row][col-1] == next_height
  # Look right
  find_trail(trailhead, row, col+1) if col + 1 < @map[row].length && @map[row][col+1] == next_height
end

if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

build(ARGV[0])

puts "::::::::::::::::: Part 1 :::::::::::::::::"
puts run

puts "::::::::::::::::: Part 2 :::::::::::::::::"
puts run(true)

