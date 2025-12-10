## Usage: ruby day-8.rb <path to file>

def run_v1(file)
  @points = []
  File.open(file).each do |line|
    @points.push(line.strip.split(',').map(&:to_i))
  end

  @circuits = {}
  @seen = {}
  count = 0
  i = 0
  while count < 1000
    point_a, point_b = find_shortest_connection
    @seen["#{point_a},#{point_b}"] = true
    @seen["#{point_b},#{point_a}"] = true

    if matching_key(point_a) && matching_key(point_b)
      combine_lists(point_a, point_b)
    elsif matching_key(point_a)
      @circuits[matching_key(point_a)].push(point_b)
    elsif matching_key(point_b)
      @circuits[matching_key(point_b)].push(point_a)
    else
      @circuits[i] = []
      @circuits[i].push(point_a)
      @circuits[i].push(point_b)
      i += 1
    end
    puts "count=#{count}"
    count += 1
  end

  connections = @circuits.values.map(&:length).sort.reverse
  connections[0...3].reduce(:*)
end

def combine_lists(point_a, point_b)
  key_a = matching_key(point_a)
  key_b = matching_key(point_b)

  return if key_a == key_b

  @circuits[key_a] = @circuits[key_a].concat(@circuits[key_b])
  @circuits.delete(key_b)
end

def matching_key(point)
  @circuits.find { |key, values| values.include?(point) }&.first
end

def find_shortest_connection
  shortest = distance(@points[0], @points[1])
  shortest_points = [@points[0], @points[1]]
  @points.each_with_index do |point_a, i|
    @points[i+1..].each do |point_b|
      hypo = distance(point_a, point_b)
      if shortest > hypo && !@seen.key?("#{point_a},#{point_b}")
        shortest = hypo
        shortest_points = [point_a, point_b]
      end
    end
  end
  shortest_points
end

def distance(point_a, point_b)
  x_1, y_1, z_1 = point_a
  x_2, y_2, z_2 = point_b

  Math.sqrt((x_1 - x_2)**2 + (y_1 - y_2)**2 + (z_1 - z_2)**2)
end

if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

puts "::::::::::::::::: Part 1 :::::::::::::::::"
puts run_v1(ARGV[0])

#puts "::::::::::::::::: Part 2 :::::::::::::::::"
#puts run_v2(ARGV[0])

