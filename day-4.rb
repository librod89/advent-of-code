## Usage: ruby day-4.rb <path to file>

def find_union(line)
  assignments = line.strip.split(',')

  first_ass = assignments[0].split('-')
  second_ass = assignments[1].split('-')

  @first_list = (first_ass[0]..first_ass[1]).to_a
  @second_list = (second_ass[0]..second_ass[1]).to_a

  union = @first_list & @second_list
end

def find_fully_contained(file)
  fully_contained = 0

  File.open(file).each do |line|
    union = find_union(line)
    fully_contained += 1 if union == @first_list || union == @second_list
  end

  fully_contained
end

def find_any_overlap(file)
  overlap = 0

  File.open(file).each do |line|
    overlap += 1 unless find_union(line).empty?
  end

  overlap
end


if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

puts "::::::::::::::::: V1 :::::::::::::::::"
puts find_fully_contained(ARGV[0])

puts "::::::::::::::::: V2 :::::::::::::::::"
puts find_any_overlap(ARGV[0])
