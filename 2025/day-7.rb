## Usage: ruby day-7.rb <path to file>

def run_v1(file)
  @grid = []
  File.open(file).each_with_index do |line, i|
    line = line.strip.split('')
    @starts = [[0,line.index('S')]] if i == 0
    @grid.push(line)
  end

  count_splitters
end

def count_splitters
  @seen = {}
  splitters = {}
  while !@starts.empty?
    row, col = @starts.shift
    @seen["#{row},#{col}"] = true

    if @grid[row][col] == '^'
      splitters["#{row},#{col-1}"] = true

      if col-1 >= 0 && !@seen.key?("#{row},#{col-1}")
        @starts.push([row, col-1])
        @grid[row][col-1] = '|'
      end

      if col+1 < @grid[row].length && !@seen.key?("#{row},#{col+1}")
        @starts.push([row, col+1])
        @grid[row][col+1] = '|'
      end

      next
    end

    if @grid[row+1][col] == '.'
      @grid[row+1][col] = '|'
    end

    @starts.push([row+2, col]) if row+2 < @grid.length && !@seen.key?("#{row+1},#{col}")
  end

  splitters.keys.count
end

# https://www.reddit.com/r/adventofcode/comments/1pgb377/2025_day_7_part_2_hint/
def count_timelines
  @seen = {}
  splitters = {}
  @grid[@starts[0][0]][@starts[0][1]] = 1 # Convert S to 1
  while !@starts.empty?
    row, col = @starts.shift
    next if @seen.key?("#{row},#{col}")

    @seen["#{row},#{col}"] = true
    #puts "row=#{row},col=#{col} => #{@grid[row][col]}"
    #display_grid
    if @grid[row][col] == '^'
      splitters["#{row},#{col-1}"] = true

      if col-1 >= 0 && !@seen.key?("#{row},#{col-1}")
        @starts.push([row, col-1])
        @grid[row][col-1] = 0 if @grid[row][col-1] == "."
        #puts "@grid[row][col-1] = #{@grid[row][col-1]} and adding #{@grid[row-1][col]}"
        @grid[row][col-1] += @grid[row-1][col]
      end

      if col+1 < @grid[row].length && !@seen.key?("#{row},#{col+1}")
        @starts.push([row, col+1])
        @grid[row][col+1] = 0 if @grid[row][col+1] == "."
        #puts "@grid[row][col+1] = #{@grid[row][col+1]} and adding #{@grid[row-1][col]}"
        @grid[row][col+1] += @grid[row-1][col]
      end

      next
    elsif @grid[row][col] == '.'
      @grid[row][col] = @grid[row-1][col]
    end

    # if @grid[row+1][col] == '.'
    #   @grid[row+1][col] = @grid[row][col]
    # end

    @starts.push([row+1, col]) if row+1 < @grid.length && !@seen.key?("#{row+1},#{col}")
  end
  #display_grid
end

def display_grid
  @grid.each do |line|
    puts "#{line.map(&:to_s)}"
  end
end

if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

puts "::::::::::::::::: Part 1 :::::::::::::::::"
puts run_v1(ARGV[0])

#puts "::::::::::::::::: Part 2 :::::::::::::::::"
#puts run_v2(ARGV[0])
