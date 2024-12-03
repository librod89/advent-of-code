## Usage: ruby day-3.rb <path to file>

def run_v1(file)
  total = 0
  File.open(file).each do |line|
    matches = line.scan(/mul\(\d+,\d+\)/)

    matches.each do |match|
      total += multiply(match)
    end
  end

  total
end

def run_v2(file)
  total = 0
  enabled = true
  File.open(file).each do |line|
    match_indexes = find_all_indexes(line, /mul\(\d+,\d+\)/)
    enabled_indexes = find_all_indexes(line, /do\(\)/)
    disabled_indexes = find_all_indexes(line, /don't\(\)/)

    enabled_ptr = 0
    disabled_ptr = 0
    match_indexes.each do |i|
      if disabled_indexes.length > disabled_ptr && disabled_indexes[disabled_ptr] < i
        enabled = false
        disabled_ptr += 1
      elsif enabled_indexes.length > enabled_ptr && enabled_indexes[enabled_ptr] < i
        enabled = true
        enabled_ptr += 1
      end

      next unless enabled

      match = line[i..].scan(/mul\(\d+,\d+\)/).first
      total += multiply(match)
    end
  end
  total
end

def multiply(match)
  numbers = match.scan(/\d+,\d+/).first.split(',').map(&:to_i)
  numbers.first * numbers.last
end

def find_all_indexes(str, pattern)
  str.enum_for(:scan, pattern).map { Regexp.last_match.begin(0) }
end

if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

puts "::::::::::::::::: Part 1 :::::::::::::::::"
puts run_v1(ARGV[0])

puts "::::::::::::::::: Part 2 :::::::::::::::::"
puts run_v2(ARGV[0])
