## Usage: ruby day-9.rb <path to file>

EMPTY = '.'

def build_disk_map(file)
  File.open(file).each do |line|
    @disk_map = line.strip.split('').map(&:to_i)
  end
end

def build_layout
  @layout = []
  id = 0
  iter = 0
  free_space = false
  while iter < @disk_map.length do
    (1..@disk_map[iter]).each { @layout.push(free_space ? EMPTY : id) }
    id += 1 unless free_space
    iter += 1
    free_space = !free_space
  end
end

def checksum
  total = 0
  @layout.each_with_index do |num, i|
    next if num == EMPTY

    total += num * i
  end
  total
end

### PART 1 ###

def fill_in_gaps
  @layout.each_with_index do |num, i|
    break unless more_nums?(i)
    next unless num == EMPTY

    last_iter = find_last_digit
    @layout[i] = @layout[last_iter]
    @layout[last_iter] = EMPTY
  end
end

def find_last_digit
  iter = @layout.length - 1
  while iter >= 0 do
    if @layout[iter] == EMPTY
      iter -= 1
      next
    end

    break
  end

  iter
end

def more_nums?(i)
  @layout[i..].any? { |e| e.to_s =~ /^\d+$/ }
end

### PART 2 ###

def fill_in_gaps_whole_files
  iter = @layout.length - 1
  id = nil
  while iter >= 0 do
    if @layout[iter] == EMPTY || (id != nil && id <= @layout[iter])
      iter -= 1
      next
    end

    id = @layout[iter]
    file = find_file(iter)
    find_empty_spot(file, iter)
    iter -= file.length
  end
end

def find_file(iter)
  file_i = iter
  num = @layout[file_i]
  file = []
  while file_i >= 0 && @layout[file_i] == num do
    file.push(num)
    file_i -= 1
  end
  file
end

def find_empty_spot(file, iter)
  empty_spot = 0
  @layout.each_with_index do |num, i|
    break if i > iter

    if num == EMPTY
      empty_spot += 1
      if empty_spot == file.length
        file_i = iter
        file.each do |f|
          @layout[i] = f
          @layout[file_i] = EMPTY
          i -= 1
          file_i -= 1
        end
        break
      end
    else
      empty_spot = 0
    end
  end
end

def run_v1(file)
  build_disk_map(file)
  build_layout
  fill_in_gaps
  checksum
end

def run_v2(file)
  build_disk_map(file)
  build_layout
  fill_in_gaps_whole_files
  checksum
end

puts "::::::::::::::::: Part 1 :::::::::::::::::"
puts run_v1(ARGV[0])

puts "::::::::::::::::: Part 2 :::::::::::::::::"
puts run_v2(ARGV[0])
