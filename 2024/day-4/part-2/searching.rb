def diagonal_down_right(row, col)
  return false if row + 1 >= @arr.length
  return false if col + 1 >= @arr[row+1].length

  @arr[row+1][col+1]
end

def diagonal_up_right(row, col)
  return false if row - 1 < 0
  return false if col + 1 >= @arr[row-1].length

  @arr[row-1][col+1]
end

def diagonal_up_left(row, col)
  return false if row - 1 < 0
  return false if col - 1 < 0

  @arr[row-1][col-1]
end

def diagonal_down_left(row, col)
  return false if row + 1 >= @arr.length
  return false if col - 1 < 0

  @arr[row+1][col-1]
end
