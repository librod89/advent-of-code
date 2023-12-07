CARDS_V1 = {
  "A" => 14,
  "K" => 13,
  "Q" => 12,
  "J" => 11,
  "T" => 10,
  "9" => 9,
  "8" => 8,
  "7" => 7,
  "6" => 6,
  "5" => 5,
  "4" => 4,
  "3" => 3,
  "2" => 2
}

CARDS_V2 = {
  "A" => 14,
  "K" => 13,
  "Q" => 12,
  "T" => 10,
  "9" => 9,
  "8" => 8,
  "7" => 7,
  "6" => 6,
  "5" => 5,
  "4" => 4,
  "3" => 3,
  "2" => 2,
  "J" => 1,
}

def merge_sort(hands, version)
  @version = version
  return hands if hands.length <= 1

  size = hands.length
  mid = (size / 2).round
  left = merge_sort(hands[0...mid], version)
  right = merge_sort(hands[mid...size], version)

  merge(hands, left, right)
end

def merge(array, sorted_left, sorted_right)
  left_size = sorted_left.length
  right_size = sorted_right.length

  array_pointer = 0
  left_pointer = 0
  right_pointer = 0

  while left_pointer < left_size && right_pointer < right_size
    if left_lower?(sorted_left[left_pointer], sorted_right[right_pointer])
      array[array_pointer] = sorted_left[left_pointer]
      left_pointer += 1
    else
      array[array_pointer] = sorted_right[right_pointer]
      right_pointer += 1
    end
    array_pointer += 1
  end

  while left_pointer < left_size
      array[array_pointer] = sorted_left[left_pointer]
      left_pointer += 1
      array_pointer += 1
  end

  while right_pointer < right_size
    array[array_pointer] = sorted_right[right_pointer]
    right_pointer += 1
    array_pointer += 1
  end

  array
end

def left_lower?(left, right)
  cards = @version === 1 ? CARDS_V1 : CARDS_V2
  (0...5).each do |index|
    if cards[@hands[left][:hand][index]] === cards[@hands[right][:hand][index]]
      next
    elsif cards[@hands[left][:hand][index]] < cards[@hands[right][:hand][index]]
      return true
    else
      return false
    end
  end
end
