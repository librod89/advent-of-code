## Usage: ruby day-5.rb <path to file>

@seeds = []
@almanac = {}
@order = {}

def run_v1(file)
  File.open(file).each do |line|
    if line.start_with?("seeds:") # seeds: 79 14 55 13
      @seeds = line.split(":")[1].strip.split(" ").map(&:to_i)
    elsif line.strip.empty?
      next
    elsif line.strip.end_with?("map:") # seed-to-soil map:
      @source, @destination = line.split(" ")[0].split("-to-")
      @almanac[@source] = {}
      @order[@source] = @destination
    else
      dest, source, length = line.split(" ").map(&:to_i) # 50 98 2
      @almanac[@source][source] = { destination: @destination, range: length, start: dest }
    end
  end

  minimum_location = nil
  @seeds.each do |s|
    location = lookup_in_almanac(s)
    minimum_location = location if minimum_location.nil? || minimum_location > location
  end
  minimum_location
end

def lookup_in_almanac(seed)
  source = "seed"
  num = seed

  while source != "location" && source != nil do
    value = nil
    @almanac[source].each do |key, v|
      value = key if key <= num && key + v[:range] >= num
      break unless value.nil?
    end
    if value.nil?
      source = @order[source]
    else
      mapping = @almanac[source][value]
      length = num - value
      if length < mapping[:range]
        source = mapping[:destination]
        num = mapping[:start] + length
      end
    end
  end
  num
end

if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

puts "::::::::::::::::: Part 1 :::::::::::::::::"
puts run_v1(ARGV[0])
