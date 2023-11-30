## Usage: ruby day-10-2.rb <path to file>

ADD = "addx"
NOOP = "noop"

@stack = []
@current_cycle = 0
@register_x = 1
@canvas = ""

def check_signal
  if @current_cycle >= 40
    @canvas += "\n"
    @current_cycle -= 40
  end
end

def draw
  check_signal
  visible = [@register_x - 1, @register_x, @register_x + 1].include?(@current_cycle)
  @canvas += visible ? "#" : "."
end

def compute
  if @stack[0].nil?
    draw
    @current_cycle += 1
  else
    draw
    @current_cycle += 1
    draw
    @current_cycle += 1
    @register_x += @stack[0]
  end
end

def run(file)
  File.open(file).each do |line|
    args = line.split(' ')
    case args[0]
    when NOOP
      @stack.push(nil)
    when ADD
      @stack.push(args[1].to_i)
    end
  end

  while @stack.any? do
    compute
    @stack.shift
  end

  while @current_cycle < 40 do
    draw
    @current_cycle += 1
  end
  @canvas
end


if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

puts run(ARGV[0])
