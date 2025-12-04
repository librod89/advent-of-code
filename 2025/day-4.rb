## Usage: ruby day-4.rb <path to file>

EMPTY = "."
ROLL_OF_PAPER = "@"

def run(file)
  @grid = []
  File.open(file).each do |line|
    @grid.push(line.strip.split(''))
  end

  find_accessible_paper
end

def run_v2(file)
  @grid = []
  File.open(file).each do |line|
    @grid.push(line.strip.split(''))
  end

  rolls_removed = 0
  more_to_remove = true
  while more_to_remove do
    removed = find_accessible_paper

    rolls_removed += removed
    more_to_remove = false if removed == 0
  end

  rolls_removed
end

def display_grid
  @grid.each do |row|
    puts "#{row}"
  end
end

def find_accessible_paper
  sum = 0
  ready_for_removal = []
  @grid.each_with_index do |_, i|
    @grid[i].each_with_index do |_, j|
      next unless @grid[i][j] == ROLL_OF_PAPER

      empty_spaces = 0
      empty_spaces += 1 if top_left(i, j)
      empty_spaces += 1 if left(i, j)
      empty_spaces += 1 if bottom_left(i, j)
      empty_spaces += 1 if top(i, j)
      empty_spaces += 1 if bottom(i, j)
      empty_spaces += 1 if top_right(i, j)
      empty_spaces += 1 if right(i, j)
      empty_spaces += 1 if bottom_right(i, j)

      if empty_spaces > 4
        sum += 1
        ready_for_removal.push([i, j])
      end
    end
  end

  ready_for_removal.each do |row, col|
    @grid[row][col] = EMPTY
  end

  sum
end

def top_left(i, j)
  return true unless i-1 >= 0 && j-1 >= 0

  @grid[i-1][j-1] == EMPTY
end

def left(i, j)
  return true unless j-1 >= 0

  @grid[i][j-1] == EMPTY
end

def bottom_left(i, j)
  return true unless i+1 < @grid.length && j-1 >= 0

  @grid[i+1][j-1] == EMPTY
end

def top(i, j)
  return true unless i-1 >= 0

  @grid[i-1][j] == EMPTY
end

def bottom(i, j)
  return true unless i+1 < @grid.length

  @grid[i+1][j] == EMPTY
end

def top_right(i, j)
  return true unless i-1 >= 0 && j+1 < @grid.length

  @grid[i-1][j+1] == EMPTY
end

def right(i, j)
  return true unless j+1 < @grid.length

  @grid[i][j+1] == EMPTY
end

def bottom_right(i, j)
  return true unless i+1 < @grid.length && j+1 < @grid.length

  @grid[i+1][j+1] == EMPTY
end


if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

puts "::::::::::::::::: Part 1 :::::::::::::::::"
puts run(ARGV[0])

puts "::::::::::::::::: Part 2 :::::::::::::::::"
puts run_v2(ARGV[0])
