## Usage: ruby day-9.rb <path to file>

def run(file, version)
  history = 0
  File.open(file).each do |line|
    @steps = []
    input = line.strip.split(" ").map(&:to_i)
    @steps.push(input)
    sequence(input)
    if version === 1
      extrapolate
      history += @steps[0].last
    else
      extrapolate_backwards
      history += @steps[0].first
    end
  end
  history
end

def sequence(input)
  return input if input.uniq.length === 1 && input.uniq[0] === 0

  new_input = []
  index = 0
  while index < input.length - 1 do
    new_input.push(input[index+1] - input[index])
    index += 1
  end
  @steps.push(new_input)
  sequence(new_input)
end

def extrapolate
  index = @steps.length - 1
  @steps[index].push(0)
  while index > 0 do
    below = @steps[index].last
    above = @steps[index - 1].last
    @steps[index - 1].push(above + below)
    index -= 1
  end
end

def extrapolate_backwards
  index = @steps.length - 1
  @steps[index].prepend(0)
  while index > 0 do
    below = @steps[index].first
    above = @steps[index - 1].first
    @steps[index - 1].prepend(above - below)
    index -= 1
  end
end

if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

puts "::::::::::::::::: Part 1 :::::::::::::::::"
puts run(ARGV[0], 1)

puts "::::::::::::::::: Part 2 :::::::::::::::::"
puts run(ARGV[0], 2)
