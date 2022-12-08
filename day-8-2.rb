## Usage: ruby day-8-2.rb <path to file>

def look_left(row, col)
  tree = @grid[row][col]

  trees_seen = 0
  col -= 1
  while col >= 0 do
    trees_seen += 1
    break if @grid[row][col] >= tree
    col -= 1
  end

  trees_seen
end

def look_right(row, col)
  tree = @grid[row][col]

  trees_seen = 0
  col += 1
  while col < max_col do
    trees_seen += 1
    break if @grid[row][col] >= tree
    col += 1
  end

  trees_seen
end

def look_up(row, col)
  tree = @grid[row][col]

  trees_seen = 0
  row -= 1
  while row >= 0 do
    trees_seen += 1
    break if @grid[row][col] >= tree
    row -= 1
  end

  trees_seen
end

def look_down(row, col)
  tree = @grid[row][col]

  trees_seen = 0
  row += 1
  while row < max_row do
    trees_seen += 1
    break if @grid[row][col] >= tree
    row += 1
  end

  trees_seen
end

def max_row
  @grid[0].length
end

def max_col
  @grid.length
end

def run(file)
  @grid = []
  File.open(file).each do |line|
    @grid.push(line.strip.split('').map(&:to_i))
  end

  scenic_scores = {}
  row = 0
  while row < max_row do
    col = 0
    while col < max_col do
      scenic_scores["#{row}/#{col}"] = look_left(row, col) * look_up(row, col) * look_right(row, col) * look_down(row, col)
      col += 1
    end
    row += 1
  end

  scenic_scores.values.max
end

if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

puts "::::::::::::::::: Highest Scenic Score :::::::::::::::::"
puts run(ARGV[0])
