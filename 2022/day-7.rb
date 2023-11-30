## Usage: ruby day-7.rb <path to file>

# Hash @directories looks like:
# dir-/ => { a.txt: 123, dir-c: 0, dir-b: 111 }
# dir-b => { gg.txt: 111 }

# attempt 1 = 1607821
# attempt 2 = 1938569

CHANGE_DIR = "cd"
LIST = "ls"

def move_up_and_calculate_size
  dir_size = current_dir.values.sum
  last_dir = @stack.pop
  @current_dir_name = @stack.last
  current_dir[dir_name(last_dir)] += dir_size
end

def sum_directory_sizes
  @directories.keys.reduce(0) do |total, dir_name|
    dir_sum = @directories[dir_name].values.sum
    dir_sum = 0 if dir_sum > 100000
    total + dir_sum
  end
end

def current_dir
  @directories[dir_name(@current_dir_name)]
end

def dir_name(str)
  "#{@stack.join('/')}/dir-#{str}"
end

def run(file)
  @current_dir_name = nil
  @directories = {}
  cmd = nil
  @stack = []
  File.open(file).each do |line|
    if @current_dir_name == nil
      ## initialize everything
      @current_dir_name = "/"
      @stack = ["/"]
      @directories[dir_name("/")] = {}
      next
    end
    if line.start_with?("$")
      if line.include?("cd")
        cmd = CHANGE_DIR
        arg = line.split(' ').last
        case arg
        when ".."
          move_up_and_calculate_size
        else
          ## move in one level
          @directories[dir_name(arg)] = {}
          @current_dir_name = arg
          @stack.push(arg)
        end
      else
        cmd = LIST
      end
    else
      case cmd
      when LIST
        if line.start_with?("dir")
          current_dir[dir_name(line.split(' ').last)] ||= 0
        else
          size, filename = line.split(' ')
          current_dir[filename] ||= size.to_i
        end
      end
    end
  end

  while @stack.length > 1 do
    move_up_and_calculate_size
  end
  #puts "#{@directories}"
  sum_directory_sizes
end

if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

puts "::::::::::::::::: Part 1 :::::::::::::::::"
puts run(ARGV[0])
