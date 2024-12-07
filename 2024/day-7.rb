## Usage: ruby day-7.rb <path to file>

class Tree
  attr_accessor :children, :value

  def initialize(v)
    @value = v
    @children = []
  end
end

ADD = '+'
MULTIPLY = '*'
CONCAT = '|'

def run(file, concat = false)
  @concat = concat
  total = 0
  File.open(file).each do |line|
    first, second = line.split(':')
    @value = first.to_i
    @numbers = second.strip.split(' ').map(&:to_i)

    @found = false
    t = build_tree(@numbers)
    traverse(t)
    total += @value if @found
  end
  total
end

def build_tree(numbers)
  t = Tree.new(numbers[0])
  return t unless numbers.length > 1

  t.children << Tree.new(ADD)
  t.children << Tree.new(MULTIPLY)
  t.children << Tree.new(CONCAT) if @concat

  t.children[0].children << build_tree(numbers[1..])
  t.children[1].children << build_tree(numbers[1..])
  t.children[2].children << build_tree(numbers[1..]) if @concat

  return t
end

def traverse(t, expression = '')
  return if @found

  expression += t.value.to_s

  if t.children.length == 0
    @found = @value == evaluate(expression)
    return
  end

  traverse(t.children[0], expression)
  traverse(t.children[1], expression) if t.children.length > 1
  traverse(t.children[2], expression) if t.children.length > 2 && @concat
end

def evaluate(expression)
  total = 0
  @numbers.each_with_index do |num, i|
    break if i+1 >= @numbers.length
    if i == 0
      total += num
    end

    _, expression = expression.split(num.to_s, 2)
    operator = expression[0]
    case operator
    when ADD
      total += @numbers[i+1]
    when MULTIPLY
      total *= @numbers[i+1]
    when CONCAT
      total = (total.to_s + @numbers[i+1].to_s).to_i
    else
      puts "SOMETHING WENT WRONG #{operator}"
    end
  end
  total
end

if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

puts "::::::::::::::::: Part 1 :::::::::::::::::"
puts run(ARGV[0])

puts "::::::::::::::::: Part 2 :::::::::::::::::"
puts run(ARGV[0], true)
