## Usage: ruby day-3-2.rb <path to file>

@schematic = []

def initialize_schematic(file)
  i, j = 0, 0
  File.open(file).each do |line|
    @schematic[i] = []
    line.strip.split('').each do |l|
      @schematic[i][j] = l
      j += 1
    end
    i += 1
    j = 0
  end
end

def run
  sum = 0
  @schematic.each_with_index do |line, i|
    line.each_with_index do |part, j|
      sum += look_around(part, i, j)
    end
  end
  sum
end

def look_around(part, i, j)
  ratio = 0
  if part === '*'
    adjacent_to = 0
    ratio = 1
    if look_left(i, j)
      adjacent_to += 1
      ratio *= get_entire_num(i, j-1)
    end
    if look_right(i, j)
      adjacent_to += 1
      ratio *= get_entire_num(i, j+1)
    end
    if look_down(i, j)
      adjacent_to += 1
      ratio *= get_entire_num(i+1, j)
    else
      if look_right(i+1, j) # down/right
        adjacent_to += 1
        ratio *= get_entire_num(i+1, j+1)
      end
      if look_left(i+1, j) # down/left
        adjacent_to += 1
        ratio *= get_entire_num(i+1, j-1)
      end
    end
    if look_up(i, j)
      adjacent_to += 1
      ratio *= get_entire_num(i-1, j)
    else
      if look_right(i-1, j) # up/right
        adjacent_to += 1
        ratio *= get_entire_num(i-1, j+1)
      end
      if look_left(i-1, j) # up/left
        adjacent_to += 1
        ratio *= get_entire_num(i-1, j-1)
      end
    end
    ratio = 0 if adjacent_to != 2
  end

  return ratio
end

def get_entire_num(i, j)
  (nums_to_the_left(i, j) + @schematic[i][j] + nums_to_the_right(i, j)).to_i
end

def nums_to_the_right(i, j)
  nums = ''
  while j + 1 < @schematic[i].length && is_num?(@schematic[i][j+1])
    nums += @schematic[i][j+1]
    j += 1
  end
  nums
end

def nums_to_the_left(i, j)
  nums = ''
  while j - 1 >= 0 && is_num?(@schematic[i][j-1])
    nums += @schematic[i][j-1]
    j -= 1
  end
  nums.reverse
end

def is_num?(str)
  !!str.match(/\d/)
end

def look_up(i, j)
  return false if i - 1 <= 0

  return is_num?(@schematic[i-1][j])
end

def look_left(i, j)
  return false if i > @schematic.length - 1 || i < 0
  return false if j - 1 <= 0

  return is_num?(@schematic[i][j-1])
end

def look_down(i,  j)
  return false if i + 1 > @schematic.length - 1

  return is_num?(@schematic[i+1][j])
end

def look_right(i, j)
  return false if i > @schematic.length - 1 || i < 0
  return false if j + 1 > @schematic[i].length - 1

  return is_num?(@schematic[i][j+1])
end

if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

initialize_schematic(ARGV[0])

puts "::::::::::::::::: Part 2 :::::::::::::::::"
puts run
