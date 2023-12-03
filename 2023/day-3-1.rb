## Usage: ruby day-3-1.rb <path to file>

@schematic = []
@looked_at = []

def initialize_schematic(file)
  i, j = 0, 0
  File.open(file).each do |line|
    @schematic[i] = []
    @looked_at[i] = []
    line.strip.split('').each do |l|
      @schematic[i][j] = l
      @looked_at[i][j] = false
      j += 1
    end
    i += 1
    j = 0
  end
end

def run_v1
  sum = 0
  @schematic.each_with_index do |line, i|
    line.each_with_index do |part, j|
      sum += (part + nums_to_the_right(i, j)).to_i if look_around(part, i, j)
    end
  end
  sum
end

def look_around(part, i, j)
  found = false
  if is_num?(part) && !@looked_at[i][j]
    if j + 1 < @schematic[i].length && is_num?(@schematic[i][j+1])
      # start at the right most digit in this number
      found = look_around(@schematic[i][j+1], i, j+1)
    end

    if look_left(i, j) || look_up(i, j) || look_down(i, j) || look_right(i, j) || look_diagonal(i, j)
      @looked_at[i][j] = true
      found = true
    end
  end

  return found
end

def nums_to_the_right(i, j)
  nums = ''
  while j + 1 < @schematic[i].length && is_num?(@schematic[i][j+1])
    nums += @schematic[i][j+1]
    j += 1
  end
  nums
end

def is_num?(str)
  !!str.match(/\d/)
end

def is_symbol?(str)
  return false if str === '.'

  !!str.match(/\A\W*\z/)
end

def look_up(i, j)
  return false if i - 1 <= 0

  return is_symbol?(@schematic[i-1][j])
end

def look_left(i, j)
  return false if i > @schematic.length - 1 || i < 0
  return false if j - 1 <= 0

  return is_symbol?(@schematic[i][j-1])
end

def look_down(i,  j)
  return false if i + 1 > @schematic.length - 1

  return is_symbol?(@schematic[i+1][j])
end

def look_right(i, j)
  return false if i > @schematic.length - 1 || i < 0
  return false if j + 1 > @schematic[i].length - 1

  return is_symbol?(@schematic[i][j+1])
end

def look_diagonal(i, j)
  look_right(i+1, j) ||   # down/right
    look_left(i+1, j) ||  # down/left
    look_right(i-1, j) || # up/right
    look_left(i-1, j)     # up/left
end

if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

initialize_schematic(ARGV[0])

puts "::::::::::::::::: Part 1 :::::::::::::::::"
puts run_v1
