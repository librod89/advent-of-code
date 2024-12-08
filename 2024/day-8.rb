## Usage: ruby day-8.rb <path to file>

EMPTY = '.'

def build(file)
  @map = []
  File.open(file).each do |line|
    @map.push(line.strip.split(''))
  end
end

def run(all_antinodes: false)
  @all_antinodes = all_antinodes
  @locations = {}
  @map.each_with_index do |_r, row|
    @map.each_with_index do |_c, col|
      next if @map[row][col] == EMPTY

      match_frequency(row, col)
    end
  end
  @locations.keys.count
end

def match_frequency(freq_row, freq_col)
  freq = @map[freq_row][freq_col]
  @map.each_with_index do |_r, row|
    next unless @map[row].include?(freq)

    @map.each_with_index do |_c, col|
      next if row == freq_row && col == freq_col
      next unless @map[row][col] === freq

      # above original frequency
      mark_it(freq_row, freq_col) if @all_antinodes
      find_antinodes(freq_row, freq_col, freq_row - row, freq_col - col)

      # below matched frequency
      mark_it(row, col) if @all_antinodes
      find_antinodes(row, col, row - freq_row, col - freq_col)
    end
  end
end

def find_antinodes(freq_row, freq_col, diff_row, diff_col)
  antinode_row = freq_row + diff_row
  antinode_col = freq_col + diff_col

  while within_bounds_of_map?(antinode_row, antinode_col) do
    mark_it(antinode_row, antinode_col)

    antinode_row += diff_row
    antinode_col += diff_col
    break unless @all_antinodes
  end
end

def within_bounds_of_map?(row, col)
  row >= 0 && col >= 0 && row < @map.length && col < @map[row].length
end

def mark_it(row, col)
  @locations["#{row},#{col}"] = true
end

if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

build(ARGV[0])

puts "::::::::::::::::: Part 1 :::::::::::::::::"
puts run

puts "::::::::::::::::: Part 2 :::::::::::::::::"
puts run(all_antinodes: true)

