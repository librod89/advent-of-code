## Usage: ruby day-19.rb <path to file>

def run_v1(file)
  @patterns = []
  total = 0
  File.open(file).each do |line|
    next if line.strip.empty?

    if @patterns.empty?
      @patterns = line.strip.split(', ')
      next
    end

    @seen_patterns = {}
    @complete = false

    possible?(line.strip)
    total += 1 if @complete
  end
  total
end

def run_v2(file)
  @patterns = []
  @total = 0
  File.open(file).each do |line|
    next if line.strip.empty?

    if @patterns.empty?
      @patterns = line.strip.split(', ')
      next
    end

    @seen_patterns = {}
    possible_v2?(line.strip)
  end
  @total
end

def possible?(design, iter = 0)
  return if iter > design.length || @complete

  if iter == design.length
    @complete = true
    return
  end

  matching_patterns = @patterns.filter do |pattern|
    pattern.start_with?(design[iter])
  end

  matching_patterns.each do |pattern|
    index = design.index(pattern, iter)
    next unless index == iter
    next if @seen_patterns["#{pattern},#{index}"]

    possible?(design, index + pattern.length)

    @seen_patterns["#{pattern},#{index}"] = true
  end
end


def possible_v2?(design, iter = 0, arrangement = [])
  return false if iter > design.length

  if iter == design.length
    @seen_patterns[arrangement] = true
    @total += 1
    return true
  end

  matching_patterns = @patterns.filter do |pattern|
    pattern.start_with?(design[iter])
  end

  matching_patterns.each do |pattern|
    index = design.index(pattern, iter)
    next unless index == iter

    arrangement.push(pattern)

    next if @seen_patterns[arrangement]

    if @seen_patterns["#{pattern},#{index}"]
      @seen_patterns[arrangement] = true
      @total += 1
      arrangement.pop
      break
    end

    is_possible = possible_v2?(design, index + pattern.length, arrangement)

    @seen_patterns["#{pattern},#{index}"] = true if is_possible

    arrangement.pop
  end

  false
end

if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

puts "::::::::::::::::: Part 1 :::::::::::::::::"
puts run_v1(ARGV[0])

# Haven't gotten Part 2 working yet
# puts "::::::::::::::::: Part 2 :::::::::::::::::"
# puts run_v2(ARGV[0])
