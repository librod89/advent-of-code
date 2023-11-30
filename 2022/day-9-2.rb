## Usage: ruby day-9-2.rb <path to file>

NUM_KNOTS = 9

@visited = {}
@h_row, @h_col = 0, 0
@t_rows, @t_cols = Array.new(NUM_KNOTS) { 0 }, Array.new(NUM_KNOTS) { 0 }

def adjacent?(row, col, index)
  ## Same location
  return true if row == @t_rows[index] && col == @t_cols[index]
  ## Horizonally adjacent
  return true if row == @t_rows[index] && (col == @t_cols[index] - 1 || col == @t_cols[index] + 1)
  ## Vertically adjacent
  return true if col == @t_cols[index] && (row == @t_rows[index] - 1 || row == @t_rows[index] + 1)
  ## Diagonally adjacent
  return true if (col == @t_cols[index] - 1 || col == @t_cols[index] + 1) && (row == @t_rows[index] - 1 || row == @t_rows[index] + 1)

  return false
end

def two_steps_away?(row, col, index)
  (row - @t_rows[index]).abs == 2 || (col - @t_cols[index]).abs == 2
end

def move_vertically(row, index)
  if row > @t_rows[index]
    # H is below T
    @t_rows[index] += 1
  elsif row < @t_rows[index]
    # H is above T
    @t_rows[index] -= 1
  end
end

def move_horizonally(col, index)
  if col > @t_cols[index]
    # H is RIGHT of T
    @t_cols[index] += 1
  elsif col < @t_cols[index]
    # H is LEFT of T
    @t_cols[index] -= 1
  end
end

def move_diagonally(row, col, index)
  move_vertically(row, index)
  move_horizonally(col, index)
end

def mark_visited
  @visited["#{@t_rows[NUM_KNOTS-1]}/#{@t_cols[NUM_KNOTS-1]}"] = true
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
        knot = 0
        row, col = @h_row, @h_col
        while knot < NUM_KNOTS do
          two_steps_away?(row, col, knot) ? move_diagonally(row, col, knot) : move_horizonally(col, knot) unless adjacent?(row, col, knot)

          row, col = @t_rows[knot], @t_cols[knot]
          knot += 1
        end
        mark_visited
      end
    when "U"
      while iter < spaces.to_i do
        iter += 1
        @h_row -= 1
        knot = 0
        row, col = @h_row, @h_col
        while knot < NUM_KNOTS do
          two_steps_away?(row, col, knot) ? move_diagonally(row, col, knot) : move_vertically(row, knot) unless adjacent?(row, col, knot)

          row, col = @t_rows[knot], @t_cols[knot]
          knot += 1
        end
        mark_visited
      end
    when "R"
      while iter < spaces.to_i do
        iter += 1
        @h_col += 1
        knot = 0
        row, col = @h_row, @h_col
        while knot < NUM_KNOTS do
          two_steps_away?(row, col, knot) ? move_diagonally(row, col, knot) : move_horizonally(col, knot) unless adjacent?(row, col, knot)

          row, col = @t_rows[knot], @t_cols[knot]
          knot += 1
        end
        mark_visited
      end
    when "D"
      while iter < spaces.to_i do
        iter += 1
        @h_row += 1
        knot = 0
        row, col = @h_row, @h_col
        while knot < NUM_KNOTS do
          two_steps_away?(row, col, knot) ? move_diagonally(row, col, knot) : move_vertically(row, knot) unless adjacent?(row, col, knot)

          row, col = @t_rows[knot], @t_cols[knot]
          knot += 1
        end
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

puts "::::::::::::::::: Part 2 :::::::::::::::::"
puts run(ARGV[0])

