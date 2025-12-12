## Usage: ruby day-11.rb <path to file>

YOU = "you"
OUT = "out"

def run_v1(file)
  @inputs = {}
  File.open(file).each do |line|
    device, outputs = line.strip.split(":")
    @inputs[device] = outputs.split(' ')
  end

  count_paths_from_you_to_out
end

def count_paths_from_you_to_out
  @count = 0
  @inputs[YOU].each do |output|
    leads_to_out_v1?(output)
  end
  @count
end

def leads_to_out_v1?(output)
  if output == OUT
    @count += 1
    return
  end

  @inputs[output].each { |value| leads_to_out_v1?(value) }
end

#######################################################

SVR = "svr"
FFT = "fft"
DAC = "dac"

def run_v2(file)
  @inputs = {}
  File.open(file).each do |line|
    device, outputs = line.strip.split(":")
    @inputs[device] = outputs.split(' ')
  end

  build_paths_from_svr_to_out
end

def build_paths_from_svr_to_out
  @path_count = 0
  @inputs[SVR].each do |output|
    leads_to_out_v2?(output, "#{SVR},#{output}")
    puts "path count #{@path_count}"
  end
  @path_count
end

def leads_to_out_v2?(output, path)
  if output == OUT
    @path_count += 1 if path.include?('fft') && path.include?('dac')
    return
  end

  @inputs[output].each do |value|
    leads_to_out_v2?(value, "#{path},#{value}")
  end
end

if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

puts "::::::::::::::::: Part 1 :::::::::::::::::"
puts run_v1(ARGV[0])

#puts "::::::::::::::::: Part 2 :::::::::::::::::"
#puts run_v2(ARGV[0])
