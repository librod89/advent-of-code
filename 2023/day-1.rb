## Usage: ruby day-1.rb <path to file>

STR_TO_INT = {
  'one'   => '1',
  'two'   => '2',
  'three' => '3',
  'four'  => '4',
  'five'  => '5',
  'six'   => '6',
  'seven' => '7',
  'eight' => '8',
  'nine'  => '9',
}.freeze

def run_v1(file)
  total = 0
  File.open(file).each do |line|
    numbers = line.scan(/\d/)
    total += (numbers.first + numbers.last).to_i
  end
  total
end

def run_v2(file)
  total = 0
  File.open(file).each do |line|
    numbers = convert_string_to_num(line).scan(/\d/)
    total += (numbers.first + numbers.last).to_i
  end
  total
end

def convert_string_to_num(str)
  index_at = {}
  STR_TO_INT.keys.each do |substring|
    # https://stackoverflow.com/questions/43329481/find-all-indices-of-a-substring-within-a-string
    indices = str.enum_for(:scan, /(?=#{substring})/).map { Regexp.last_match.offset(0).first }
    next unless indices

    indices.each { |i| index_at[i] = substring }
  end

  first_index = index_at.min_by(&:first)
  last_index = index_at.max_by(&:first)

  return str unless first_index

  index, num = first_index
  str[index] = STR_TO_INT[num]

  index, num = last_index
  str[index] = STR_TO_INT[num]

  str
end

if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

puts "::::::::::::::::: Part 1 :::::::::::::::::"
puts run_v1(ARGV[0])

puts "::::::::::::::::: Part 2 :::::::::::::::::"
puts run_v2(ARGV[0])
