WALL = '#'
BOX = 'O'
EMPTY = '.'
ROBOT = '@'
LEFT = '<'
RIGHT = '>'
UP = '^'
DOWN = 'v'

def move(row, col, direction)
  return if @map[row][col] == WALL

  if @map[row][col] == BOX
    case direction
    when LEFT
      move_boxes_left(row, col)
    when RIGHT
      move_boxes_right(row, col)
    when UP
      move_boxes_up(row, col)
    when DOWN
      move_boxes_down(row, col)
    else
      puts "DIDN'T FIND WHAT YOU EXPECTED IN DIRECTION #{direction}"
    end
  end

  return if @map[row][col] != EMPTY

  @map[row][col] = ROBOT
  @map[@robot_x][@robot_y] = EMPTY
  @robot_x = row
  @robot_y = col
end

def move_boxes_left(row, col)
  initial_row, initial_col = row, col

  while col >= 0 do
    if @map[row][col] == BOX
      col -= 1
    else
      break
    end
  end

  return if @map[row][col] == WALL

  if @map[row][col] == BOX
    puts "SOMETHING WENT WRONG MOVING BOXES LEFT! #{@map[row][col]}"
  end

  while col < initial_col do
    @map[row][col] = BOX
    col += 1
    @map[row][col] = EMPTY
  end
end

def move_boxes_right(row, col)
  initial_row, initial_col = row, col

  while col < @map[row].length do
    if @map[row][col] == BOX
      col += 1
    else
      break
    end
  end

  return if @map[row][col] == WALL

  if @map[row][col] == BOX
    puts "SOMETHING WENT WRONG MOVING BOXES RIGHT! #{@map[row][col]}"
  end

  while col > initial_col do
    @map[row][col] = BOX
    col -= 1
    @map[row][col] = EMPTY
  end
end

def move_boxes_up(row, col)
  initial_row, initial_col = row, col

  while row >= 0 do
    if @map[row][col] == BOX
      row -= 1
    else
      break
    end
  end

  return if @map[row][col] == WALL

  if @map[row][col] == BOX
    puts "SOMETHING WENT WRONG MOVING BOXES UP! #{@map[row][col]}"
  end

  while row < initial_row do
    @map[row][col] = BOX
    row += 1
    @map[row][col] = EMPTY
  end
end

def move_boxes_down(row, col)
  initial_row, initial_col = row, col

  while row < @map.length do
    if @map[row][col] == BOX
      row += 1
    else
      break
    end
  end

  return if @map[row][col] == WALL

  if @map[row][col] == BOX
    puts "SOMETHING WENT WRONG MOVING BOXES DOWN! #{@map[row][col]}"
  end

  while row > initial_row do
    @map[row][col] = BOX
    row -= 1
    @map[row][col] = EMPTY
  end
end
