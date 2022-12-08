## Usage: ruby day-8-1.rb <path to file>

def look_left(row, col)
  tree = @grid[row][col]

  col -= 1
  while col >= 0 && @grid[row][col] < tree do
    col -= 1
  end

  col < 0 && @grid[row][col+1] < tree
end

def look_right(row, col)
  tree = @grid[row][col]

  col += 1
  while col < max_col && @grid[row][col] < tree do
    col += 1
  end

  col == max_col && @grid[row][col-1] < tree
end

def look_up(row, col)
  tree = @grid[row][col]

  row -= 1
  while row >= 0 && @grid[row][col] < tree do
    row -= 1
  end

  row < 0 && @grid[row+1][col] < tree
end

def look_down(row, col)
  tree = @grid[row][col]

  row += 1
  while row < max_row && @grid[row][col] < tree do
    row += 1
  end

  row == max_row && @grid[row-1][col] < tree
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

  visible_trees = 0
  row = 0
  while row < max_row do
    col = 0
    while col < max_col do
      if row == 0 || row == max_row - 1
        ## top or bottom of the grid
        visible_trees += 1
      elsif col == 0 || col == max_col - 1
        ## left or right of the grid
        visible_trees += 1
      else
        visible_trees += 1 if look_left(row, col) || look_up(row, col) || look_right(row, col) || look_down(row, col)
      end
      col += 1
    end
    row += 1
  end
  visible_trees
end

if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

puts "::::::::::::::::: Number of Visible Trees :::::::::::::::::"
puts run(ARGV[0])
