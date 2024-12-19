OLD_BOX = 'O'

BOX_LEFT = '['
BOX_RIGHT = ']'
WALL = '#'
EMPTY = '.'
ROBOT = '@'
LEFT = '<'
RIGHT = '>'
UP = '^'
DOWN = 'v'

def move(row, col, direction)
  return if @map[row][col] == WALL

  if [BOX_LEFT, BOX_RIGHT].include? @map[row][col]
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
    if [BOX_LEFT, BOX_RIGHT].include? @map[row][col]
      col -= 1
    else
      break
    end
  end

  return if @map[row][col] == WALL

  if [BOX_LEFT, BOX_RIGHT].include? @map[row][col]
    puts "SOMETHING WENT WRONG MOVING BOXES LEFT! #{@map[row][col]}"
  end

  while col < initial_col do
    @map[row][col] = BOX_LEFT
    col += 1
    @map[row][col] = BOX_RIGHT
    col += 1
    @map[row][col] = EMPTY
  end
end

def move_boxes_right(row, col)
  initial_row, initial_col = row, col

  while col < @map[row].length do
    if [BOX_LEFT, BOX_RIGHT].include? @map[row][col]
      col += 1
    else
      break
    end
  end

  return if @map[row][col] == WALL

  if [BOX_LEFT, BOX_RIGHT].include? @map[row][col]
    puts "SOMETHING WENT WRONG MOVING BOXES RIGHT! #{@map[row][col]}"
  end

  while col > initial_col do
    @map[row][col] = BOX_RIGHT
    col -= 1
    @map[row][col] = BOX_LEFT
    col -= 1
    @map[row][col] = EMPTY
  end
end

def move_boxes_up(row, col)
  @blocked = false
  look_above_box(row, col)

  return if @blocked

  move_boxes_up!(row, col)
end

def move_boxes_down(row, col)
  @blocked = false
  look_below_box(row, col)

  return if @blocked

  move_boxes_down!(row, col)
end

def look_above_box(row, col)
  case @map[row][col]
  when BOX_LEFT
    look_above_box(row - 1, col)
    look_above_box(row - 1, col + 1)
  when BOX_RIGHT
    look_above_box(row - 1, col)
    look_above_box(row - 1, col - 1)
  when EMPTY
    # no op
  when WALL
    @blocked = true
  end
end

def look_below_box(row, col)
  case @map[row][col]
  when BOX_LEFT
    look_below_box(row + 1, col)
    look_below_box(row + 1, col + 1)
  when BOX_RIGHT
    look_below_box(row + 1, col)
    look_below_box(row + 1, col - 1)
  when EMPTY
    # no op
  when WALL
    @blocked = true
  end
end

def move_boxes_up!(row, col)
  case @map[row][col]
  when BOX_LEFT
    move_boxes_up!(row-1, col)
    move_boxes_up!(row-1, col+1)

    if @map[row-1][col] == EMPTY && @map[row-1][col+1] == EMPTY
      @map[row-1][col] = BOX_LEFT
      @map[row-1][col+1] = BOX_RIGHT
      @map[row][col] = EMPTY
      @map[row][col+1] = EMPTY
    end
  when BOX_RIGHT
    move_boxes_up!(row-1, col)
    move_boxes_up!(row-1, col-1)

    if @map[row-1][col-1] == EMPTY && @map[row-1][col] == EMPTY
      @map[row-1][col-1] = BOX_LEFT
      @map[row-1][col] = BOX_RIGHT
      @map[row][col-1] = EMPTY
      @map[row][col] = EMPTY
    end
  when EMPTY
    # no op
  when WALL
    puts "SOMETHING WENT WRONG MOVING BOXES UP! #{row},#{col}"
  end
end

def move_boxes_down!(row, col)
  case @map[row][col]
  when BOX_LEFT
    move_boxes_down!(row+1, col)
    move_boxes_down!(row+1, col+1)

    if @map[row+1][col] == EMPTY && @map[row+1][col+1] == EMPTY
      @map[row+1][col] = BOX_LEFT
      @map[row+1][col+1] = BOX_RIGHT
      @map[row][col] = EMPTY
      @map[row][col+1] = EMPTY
    end
  when BOX_RIGHT
    move_boxes_down!(row+1, col)
    move_boxes_down!(row+1, col-1)

    if @map[row+1][col-1] == EMPTY && @map[row+1][col] == EMPTY
      @map[row+1][col-1] = BOX_LEFT
      @map[row+1][col] = BOX_RIGHT
      @map[row][col-1] = EMPTY
      @map[row][col] = EMPTY
    end
  when EMPTY
    # no op
  when WALL
    puts "SOMETHING WENT WRONG MOVING BOXES DOWN!"
  end
end
