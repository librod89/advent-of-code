## Usage: ruby day-6.rb <path to file>

def run_v1(file)
  File.open(file).each do |line|
    if line.start_with?("Time:")
      @times = line.split(":")[1].strip.split(" ").map(&:strip).map(&:to_i)
    elsif line.start_with?("Distance:")
      @distances = line.split(":")[1].strip.split(" ").map(&:strip).map(&:to_i)
    end
  end

  ways_to_beat = 1
  @times.each_with_index do |t, index|
    ways_to_beat *= race(t, @distances[index])
  end
  ways_to_beat
end

def run_v2(file)
  File.open(file).each do |line|
    if line.start_with?("Time:")
      @time = line.split(":")[1].delete(" ").to_i
    elsif line.start_with?("Distance:")
      @distance = line.split(":")[1].delete(" ").to_i
    end
  end

  race(@time, @distance)
end

def race(time, record_distance)
  win = 0
  time_to_charge = 1

  while time_to_charge < time do
    distance = time_to_charge * (time - time_to_charge)
    win += 1 if distance > record_distance
    time_to_charge += 1
  end

  win
end

if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

puts "::::::::::::::::: Part 1 :::::::::::::::::"
puts run_v1(ARGV[0])

puts "::::::::::::::::: Part 2 :::::::::::::::::"
puts run_v2(ARGV[0])
