WORD = {
  0 => 'X',
  1 => 'M',
  2 => 'A',
  3 => 'S'
}

def forwards(row, col)
  letter = 0
  while col < @arr[row].length do
    if WORD[letter] == @arr[row][col]
      letter += 1
      col += 1
    else
      break
    end

    if WORD[letter] == nil
      @total += 1
      break
    end
  end
end

def backwards(row, col)
  letter = 0
  while col >= 0 do
    if WORD[letter] == @arr[row][col]
      letter += 1
      col -= 1
    else
      break
    end

    if WORD[letter] == nil
      @total += 1
      break
    end
  end
end

def up(row, col)
  letter = 0
  while row >= 0 do
    if WORD[letter] == @arr[row][col]
      letter += 1
      row -= 1
    else
      break
    end

    if WORD[letter] == nil
      @total += 1
      break
    end
  end
end

def down(row, col)
  letter = 0
  while row < @arr.length do
    if WORD[letter] == @arr[row][col]
      letter += 1
      row += 1
    else
      break
    end

    if WORD[letter] == nil
      @total += 1
      break
    end
  end
end

def diagonal_down_right(row, col)
  letter = 0
  while row < @arr.length && col < @arr[row].length do
    if WORD[letter] == @arr[row][col]
      letter += 1
      row += 1
      col += 1
    else
      break
    end

    if WORD[letter] == nil
      @total += 1
      break
    end
  end
end

def diagonal_up_right(row, col)
  letter = 0
  while row >= 0 && col < @arr[row].length do
    if WORD[letter] == @arr[row][col]
      letter += 1
      row -= 1
      col += 1
    else
      break
    end

    if WORD[letter] == nil
      @total += 1
      break
    end
  end
end

def diagonal_up_left(row, col)
  letter = 0
  while row >= 0 && col >= 0 do
    if WORD[letter] == @arr[row][col]
      letter += 1
      row -= 1
      col -= 1
    else
      break
    end

    if WORD[letter] == nil
      @total += 1
      break
    end
  end
end

def diagonal_down_left(row, col)
  letter = 0
  while row < @arr.length && col >= 0 do
    if WORD[letter] == @arr[row][col]
      letter += 1
      row += 1
      col -= 1
    else
      break
    end

    if WORD[letter] == nil
      @total += 1
      break
    end
  end
end
