## Usage: ruby day-6.rb <path to file>

def find_marker(file, num_chars)
  str = []
  chars = 0
  File.open(file).each_char do |c|
    str.shift && chars += 1 if str.length == num_chars
    str.push(c)

    return chars + str.length if str.length == num_chars && str.uniq.length == str.length
  end
end

if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

puts "::::::::::::::::: Part 1 :::::::::::::::::"
puts find_marker(ARGV[0], 4)

puts "::::::::::::::::: Part 2 :::::::::::::::::"
puts find_marker(ARGV[0], 14)
