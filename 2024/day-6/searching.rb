def move_up
  return if @stopped

  if @guard_row - 1 < 0
    @guard_row = -1
    return
  end

  if @map[@guard_row-1][@guard_col] == OBSTACLE
    @map[@guard_row][@guard_col] = DIRECTIONS[:RIGHT]
    @stopped = true
  else
    @guard_row -= 1
    @positions[@guard_row][@guard_col] = MARK_IT
    move_up
  end
end

def move_down
  return if @stopped

  if @guard_row + 1 >= @map.length
    @guard_row = -1
    return
  end

  if @map[@guard_row+1][@guard_col] == OBSTACLE
    @map[@guard_row][@guard_col] = DIRECTIONS[:LEFT]
    @stopped = true
  else
    @guard_row += 1
    @positions[@guard_row][@guard_col] = MARK_IT
    move_down
  end
end

def move_right
  return if @stopped

  if @guard_col + 1 >= @map[@guard_row].length
    @guard_col = -1
    return
  end

  if @map[@guard_row][@guard_col+1] == OBSTACLE
    @map[@guard_row][@guard_col] = DIRECTIONS[:DOWN]
    @stopped = true
  else
    @guard_col += 1
    @positions[@guard_row][@guard_col] = MARK_IT
    move_right
  end
end

def move_left
  return if @stopped

  if @guard_col - 1 < 0
    @guard_col = -1
    return
  end

  if @map[@guard_row][@guard_col-1] == OBSTACLE
    @map[@guard_row][@guard_col] = DIRECTIONS[:UP]
    @stopped = true
  else
    @guard_col -= 1
    @positions[@guard_row][@guard_col] = MARK_IT
    move_left
  end
end
