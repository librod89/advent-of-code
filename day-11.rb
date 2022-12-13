## Usage: ruby day-11.rb <path to file>

NUM_MONKEYS = 8

def initialize_hashes
  @items_per_monkey = {
    0 => [83, 62, 93],
    1 => [90, 55],
    2 => [91, 78, 80, 97, 79, 88],
    3 => [64, 80, 83, 89, 59],
    4 => [98, 92, 99, 51],
    5 => [68, 57, 95, 85, 98, 75, 98, 75],
    6 => [74],
    7 => [68, 64, 60, 68, 87, 80, 82],
  }
  @operations_per_monkey = {
    0 => [:*, 17],
    1 => [:+, 1],
    2 => [:+, 3],
    3 => [:+, 5],
    4 => [:*, :old],
    5 => [:+, 2],
    6 => [:+, 4],
    7 => [:*, 19],
  }
  @test_per_monkey = {
    0 => 2,
    1 => 17,
    2 => 19,
    3 => 3,
    4 => 5,
    5 => 13,
    6 => 7,
    7 => 11,
  }
  @throws_per_monkey = {
    0 => { true => 1, false => 6 },
    1 => { true => 6, false => 3 },
    2 => { true => 7, false => 5 },
    3 => { true => 7, false => 2 },
    4 => { true => 0, false => 1 },
    5 => { true => 4, false => 0 },
    6 => { true => 3, false => 2 },
    7 => { true => 4, false => 5 },
  }

  @super_mod = @test_per_monkey.values.reduce(1) { |total, value| total * value }
end

def operation(current_monkey, old)
  num = @operations_per_monkey[current_monkey][1]

  return @operations_per_monkey[current_monkey][0], num == :old ? old : num
end

def decrease_worry(worry_level)
  worry_level %= @super_mod
end

def run(total_rounds, divide_by_three = true)
  initialize_hashes
  @monkey_inspection = Array.new(NUM_MONKEYS) { 0 }
  round = 1

  while round <= total_rounds do
    current_monkey = 0
    while current_monkey < NUM_MONKEYS do
      while @items_per_monkey[current_monkey].any? do
        item = @items_per_monkey[current_monkey].shift

        operation, num = operation(current_monkey, item)

        worry_level = item.public_send(operation, num)
        worry_level = divide_by_three ? worry_level / 3 : worry_level
        worry_level = decrease_worry(worry_level)

        divisible = worry_level % @test_per_monkey[current_monkey] == 0
        throw_to_monkey = @throws_per_monkey[current_monkey][divisible]

        @items_per_monkey[throw_to_monkey].push(worry_level)
        @monkey_inspection[current_monkey] += 1
      end
      current_monkey += 1
    end
    round += 1
  end
  @monkey_inspection.sort[-1] * @monkey_inspection.sort[-2]
end

puts "::::::::::::::::: 20 rounds :::::::::::::::::"
puts run(20)

puts "::::::::::::::::: 10k rounds :::::::::::::::::"
puts run(10_000, false)
