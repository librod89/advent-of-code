## Usage: ruby day-2.rb <path to file>

def run_v1(file)
  count = 0
  File.open(file).each do |line|
    report = line.split(' ').map(&:to_i)
    count += 1 if safe?(report)
  end
  count
end

def run_v2(file)
  count = 0
  File.open(file).each do |line|
    report = line.split(' ').map(&:to_i)
    count += 1 if safe?(report) || problem_dampener(report)
  end
  count
end

def safe?(report)
  increasing = nil
  @safe = true
  report.each_with_index do |level, i|
    if increasing.nil?
      increasing = level < report[i+1] ? true : false
    end

    break unless @safe
    break if report.length - 1 == i

    next_level = report[i+1]
    if level == next_level
      @safe = false
    else
      increasing ? check_increasing(level, next_level) : check_decreasing(level, next_level)
    end
  end
  @safe
end

def check_increasing(level, next_level)
  @safe = false if level > next_level || next_level - level > 3
end

def check_decreasing(level, next_level)
  @safe = false if level < next_level || level - next_level > 3
end

def problem_dampener(report)
  report.each_with_index do |level, i|
    report_dup = report.dup
    report_dup.delete_at(i)
    return true if safe?(report_dup)
  end
  false
end

if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

puts "::::::::::::::::: Part 1 :::::::::::::::::"
puts run_v1(ARGV[0])

puts "::::::::::::::::: Part 2 :::::::::::::::::"
puts run_v2(ARGV[0])
