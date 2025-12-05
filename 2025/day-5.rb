## Usage: ruby day-5.rb <path to file>

def run(file)
  @fresh_ingredients = []
  @ingredients = []
  ranges_complete = false
  File.open(file).each do |line|
    if line.strip.empty?
      ranges_complete = true
      next
    end

    if ranges_complete
      @ingredients.push(line.strip.to_i)
    else
      @fresh_ingredients.push(line.strip.split('-').map(&:to_i))
    end
  end

  count_ingredients
end

def count_ingredients
  count = 0
  @ingredients.each do |ingredient|
    @fresh_ingredients.each do |first, second|
      if first <= ingredient && ingredient <= second
        count += 1
        break
      end
    end
  end
  count
end

def run_v2(file)
  @fresh_ingredients = []
  File.open(file).each do |line|
    break if line.strip.empty?

    @fresh_ingredients.push(line.strip.split('-').map(&:to_i))
  end

  @fresh_ingredients.sort!
  count_fresh_ingredients
end

def count_fresh_ingredients
  @fresh_ingredients.each_with_index do |(first_a, second_a), i|
    @fresh_ingredients[i+1..].each_with_index do |(first_b, second_b), j|
      next if first_b.nil? && second_b.nil?

      index = i+1+j
      if second_a >= first_b && second_a <= second_b && first_a <= first_b
        # smaller overlapping larger
        @fresh_ingredients[index] = [first_a, second_b]
        @fresh_ingredients[i] = nil
      elsif first_a >= first_b && first_a <= second_b && second_a >= second_b
        # larger overlapping smaller
        @fresh_ingredients[index] = [first_b, second_a]
        @fresh_ingredients[i] = nil
      elsif first_a <= first_b && second_a >= second_b
        # larger completely contains smaller
        @fresh_ingredients[index] = [first_a, second_a]
        @fresh_ingredients[i] = nil
      end
    end
  end

  count = 0
  @fresh_ingredients.compact.each do |first, second|
    count += second - first + 1
  end
  count
end

if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

puts "::::::::::::::::: Part 1 :::::::::::::::::"
puts run(ARGV[0])

puts "::::::::::::::::: Part 2 :::::::::::::::::"
puts run_v2(ARGV[0])
