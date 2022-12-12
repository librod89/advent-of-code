## Usage: ruby day-10-1.rb <path to file>

ADD = "addx"
NOOP = "noop"

@stack = []
@current_cycle = 0
@register_x = 1
@strength = 0

def check_signal
  if @current_cycle == 20
    @strength += 20 * @register_x
  elsif @current_cycle == 60
    @strength += 60 * @register_x
  elsif @current_cycle == 100
    @strength += 100 * @register_x
  elsif @current_cycle == 140
    @strength += 140 * @register_x
  elsif @current_cycle == 180
    @strength += 180 * @register_x
  elsif @current_cycle == 220
    @strength += 220 * @register_x
  end
end

def compute
  if @stack[0].nil?
    @current_cycle += 1
    check_signal
  else
    @current_cycle += 1
    check_signal
    @current_cycle += 1
    check_signal
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

  @strength
end


if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

puts run(ARGV[0])
