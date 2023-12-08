## Usage: ruby day-8.rb <path to file>

def run(file, version)
  @steps = []
  @map = {}
  @starting_nodes = []
  File.open(file).each_with_index do |line, index|
    if index === 0
      @steps = line.strip.split("")
      next
    elsif line.strip.empty?
      next
    else
      # AAA = (BBB, CCC)
      node, directions = line.split("=").map(&:strip)
      @starting_nodes.push(node) if node.end_with?("A")
      left, right = directions.split(",").map(&:strip)
      @map[node] = { left: left.delete("("), right: right.delete(")") }
    end
  end
  version === 1 ? navigate_v1 : navigate_v2
end

def navigate_v1
  hops = 0
  starting_node = "AAA"
  current_step = 0

  while starting_node != "ZZZ" do
    direction = @steps[current_step] === "L" ? :left : :right
    starting_node = @map[starting_node][direction]
    hops += 1
    current_step += 1
    current_step = 0 if current_step >= @steps.length
  end
  hops
end

def navigate_v2
  step_count = []
  @starting_nodes.each do |node|
    hops = 0
    current_step = 0
    while !node.end_with?("Z") do
      direction = @steps[current_step] === "L" ? :left : :right
      node = @map[node][direction]
      hops += 1
      current_step += 1
      current_step = 0 if current_step >= @steps.length
    end
    step_count.push(hops)
  end
  step_count.reduce(1, :lcm)
end

if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

puts "::::::::::::::::: Part 1 :::::::::::::::::"
puts run(ARGV[0], 1)

puts "::::::::::::::::: Part 2 :::::::::::::::::"
puts run(ARGV[0], 2)
