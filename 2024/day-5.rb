## Usage: ruby day-5.rb <path to file>

def run(file, fix_incorrect_updates = false)
  @rules = {}
  middles = 0
  rules_complete = false
  File.open(file).each do |line|
    if line.strip.empty?
      rules_complete = true
      next
    end

    if rules_complete
      update = line.split(',').map(&:to_i)
      if fix_incorrect_updates
        # Part 2
        next if correct_ordering?(update)

        new_update = fix_ordering(update)
        middles += new_update[new_update.length / 2]
      elsif correct_ordering?(update)
        # Part 1
        middles += update[update.length / 2]
      end

      next
    end

    before, after = line.split("|").map(&:to_i)
    @rules[before] ||= []
    @rules[before].push(after)
  end
  middles
end

def correct_ordering?(update)
  correct = true
  update.each_with_index do |num, i|
    update[i+1..].each do |next_num|
      next if @rules[num]&.include?(next_num)

      if @rules[next_num]&.include?(num)
        correct = false
        break
      end
    end
    break if correct == false
  end
  correct
end

def fix_ordering(list)
  new_list = []
  list.each do |num|
    if new_list.empty?
      new_list.push(num)
      next
    end

    added = false
    new_list.each_with_index do |n, i|
      next if @rules[n]&.include?(num)

      new_list.insert(i, num)
      added = true
      break
    end

    new_list.insert(-1, num) if !added
  end
  new_list
end

if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

puts "::::::::::::::::: Part 1 :::::::::::::::::"
puts run(ARGV[0])

puts "::::::::::::::::: Part 2 :::::::::::::::::"
puts run(ARGV[0], true)
