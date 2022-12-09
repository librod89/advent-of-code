## Usage: ruby day-9-1.rb <path to file>

@visited = {}
@h_row, @h_col = 0, 0
@t_row, @t_col = 0, 0

def adjacent?
  ## Same location
  return true if @h_row == @t_row && @h_col == @t_col
  ## Horizonally adjacent
  return true if @h_row == @t_row && (@h_col == @t_col - 1 || @h_col == @t_col + 1)
  ## Vertically adjacent
  return true if @h_col == @t_col && (@h_row == @t_row - 1 || @h_row == @t_row + 1)
  ## Diagonally adjacent
  return true if (@h_col == @t_col - 1 || @h_col == @t_col + 1) && (@h_row == @t_row - 1 || @h_row == @t_row + 1)

  return false
end

def two_steps_away?
  (@h_row - @t_row).abs == 2 || (@h_col - @t_col).abs == 2
end

def move_vertically
  if @h_row > @t_row
    # H is below T
    @t_row += 1
  elsif @h_row < @t_row
    # H is above T
    @t_row -= 1
  end
end

def move_horizonally
  if @h_col > @t_col
    # H is RIGHT of T
    @t_col += 1
  elsif @h_col < @t_col
    # H is LEFT of T
    @t_col -= 1
  end
end

def move_diagonally
  move_vertically
  move_horizonally
end

def mark_visited
  @visited["#{@t_row}/#{@t_col}"] = true
end

def run(file)
  mark_visited

  File.open(file).each do |line|
    direction, spaces = line.strip.split(' ')
    iter = 0
    case direction
    when "L"
      while iter < spaces.to_i do
        iter += 1
        @h_col -= 1
        next if adjacent?

        two_steps_away? ? move_diagonally : move_horizonally
        mark_visited
      end
    when "U"
      while iter < spaces.to_i do
        iter += 1
        @h_row -= 1
        next if adjacent?

        two_steps_away? ? move_diagonally : move_vertically
        mark_visited
      end
    when "R"
      while iter < spaces.to_i do
        iter += 1
        @h_col += 1
        next if adjacent?

        two_steps_away? ? move_diagonally : move_horizonally
        mark_visited
      end
    when "D"
      while iter < spaces.to_i do
        iter += 1
        @h_row += 1
        next if adjacent?

        two_steps_away? ? move_diagonally : move_vertically
        mark_visited
      end
    end
  end

  @visited.keys.count
end

if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

puts "::::::::::::::::: Part 1 :::::::::::::::::"
puts run(ARGV[0])
