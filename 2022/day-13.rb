## Usage: ruby day-11.rb <path to file>

# First attempt: 1342
# Second attempt: 3427

def compare(left, right)
  #puts "left is empty? #{left.length == 0}"
  return true if left.length == 0

  right_order = false
  nothing_but_the_same = false
  index = 0

  left.each do |l|
    #puts "starting loop with #{l}"
    return right_order && !nothing_but_the_same if index >= right.length

    r = right[index]
    puts "comparing #{l} and #{r}"
    if l.class == Integer && r.class == Integer
      return l < r unless l == r
      nothing_but_the_same = true
    elsif l.class == Integer
      return false unless compare([l], r)
    elsif r.class == Integer
      return false unless compare(l, [r])
    else
      #puts "these are lists"
      return false unless compare(l, r)
    end
    #puts "setting right_order"
    index += 1
    right_order = true
  end

  puts "returning #{right_order}"
  return right_order
end

def run(file)
  left = nil
  right = nil
  pair = 1
  total = 0

  File.open(file).each do |line|
    if line.strip.empty?
      left = nil
      right = nil
      pair += 1
      next
    end

    packet = eval(line.strip)
    if left == nil
      left = packet
    else
      right = packet
      puts "#{left}"
      puts "#{right}"
      puts "******** Pair #{pair}"
      if compare(left, right)
        puts "CORRECT"
        total += pair
      end
      puts "\n"
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
