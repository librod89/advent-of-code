## Usage: ruby day-7.rb <path to file>

CHANGE_DIR = "cd"
LIST = "ls"

class Tree
  attr_accessor :children, :value

  def initialize(v)
    @value = v
    @children = []
  end
end

def run(file)
  current_node = Tree.new("/")

  File.open(file).each do |line|
    next if line == "$ cd /"

    if line.start_with?("$")
      if line.include?("cd")
        cmd = CHANGE_DIR
        arg = line.split(' ').last
        case arg
        when ".."

        else
          ## move in one level
          current_node << Tree.new(arg)
        end
      else
        cmd = LIST
      end
    end
  end
end

if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

puts "::::::::::::::::: Part 1 :::::::::::::::::"
puts run(ARGV[0])
