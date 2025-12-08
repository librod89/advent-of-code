## Usage: ruby day-6.rb <path to file>

ADD = "+"
MULTIPLY = "*"

def run_v1(file)
  problems = []
  File.open(file).each do |line|
    numbers = line.strip.split(' ')
    numbers.each_with_index do |num, i|
      problems.push([]) unless problems.length > i
      problems[i].push(num)
    end
  end

  result = 0
  problems.each do |numbers|
    operation = numbers.pop
    result += numbers.reduce(operation == ADD ? 0 : 1) do |acc, num|
      if operation == ADD
        acc + num.to_i
      else
        acc * num.to_i
      end
    end
  end
  result
end

def run_v2(file)
  contents = []
  File.open(file).each do |line|
    contents.push(line.chomp.split(''))
  end

  problems = []
  contents.reverse.each  do |line|
    problems.push(line)
  end

  col = 0
  result = 0
  while problems[0][col] == ADD || problems[0][col] == MULTIPLY
    operation = problems[0][col]

    numbers = []
    row = 1
    finished_equation = false
    while !finished_equation
      number = ""
      while row < problems.length
        number += problems[row][col]
        row += 1
      end

      if number.strip.empty?
        col += 1
        finished_equation = true
      else
        numbers.push(number)
        row = 1
        col += 1

        finished_equation = true if col >= problems[row].length
      end
    end

    result += numbers.reduce(operation == ADD ? 0 : 1) do |acc, num|
      if operation == ADD
        acc + num.reverse.to_i
      else
        acc * num.reverse.to_i
      end
    end
  end
  result
end

if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

puts "::::::::::::::::: Part 1 :::::::::::::::::"
puts run_v1(ARGV[0])

puts "::::::::::::::::: Part 2 :::::::::::::::::"
puts run_v2(ARGV[0])
