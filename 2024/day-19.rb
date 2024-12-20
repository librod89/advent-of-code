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
  @seen_patterns = {}
  @total = 0
  File.open(file).each do |line|
    next if line.strip.empty?

    if @patterns.empty?
      @patterns = line.strip.split(', ')
      next
    end

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
  if iter > design.length
    arrangement.each_with_index do |pattern, index|
      @seen_patterns["#{pattern},#{index}"] = false
    end
    return
  end

  if iter == design.length
    arrangement.each_with_index do |pattern, index|
      @seen_patterns["#{pattern},#{index}"] = true
    end
    @total += 1
    return
  end

  matching_patterns = @patterns.filter do |pattern|
    pattern.start_with?(design[iter])
  end

  matching_patterns.each do |pattern|
    index = design.index(pattern, iter)
    next unless index == iter

    arrangement.push(pattern)

    if @seen_patterns["#{pattern},#{index}"]
      arrangement.each_with_index do |pattern, index|
        @seen_patterns["#{pattern},#{index}"] = true
      end
      @total += 1
      arrangement.pop
      next
    elsif @seen_patterns["#{pattern},#{index}"] === false
      arrangement.pop
      next
    end

    possible_v2?(design, index + pattern.length, arrangement)

    arrangement.pop
  end
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
