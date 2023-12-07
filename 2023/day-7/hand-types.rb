def five_of_a_kind?(hand)
  hand.split("").uniq.length === 1
end

def four_of_a_kind?(hand)
  hand.split("").uniq.length === 2
end

def full_house?(hand)
  cards = hand.split("").uniq
  cards.length === 2 &&
    (
      (hand.scan(/(?=#{cards[0]})/).count === 2 && hand.scan(/(?=#{cards[1]})/).count === 3) ||
      (hand.scan(/(?=#{cards[1]})/).count === 2 && hand.scan(/(?=#{cards[0]})/).count === 3)
    )
end

def three_of_a_kind?(hand)
  cards = hand.split("").uniq
  cards.length === 3 &&
    (
      hand.scan(/(?=#{cards[0]})/).count === 3 ||
      hand.scan(/(?=#{cards[1]})/).count === 3 ||
      hand.scan(/(?=#{cards[2]})/).count === 3
    )
end

def two_pair?(hand)
  cards = hand.split("").uniq
  cards.length === 3 &&
    (
      (hand.scan(/(?=#{cards[0]})/).count === 2 && hand.scan(/(?=#{cards[1]})/).count === 2) ||
      (hand.scan(/(?=#{cards[1]})/).count === 2 && hand.scan(/(?=#{cards[2]})/).count === 2) ||
      (hand.scan(/(?=#{cards[0]})/).count === 2 && hand.scan(/(?=#{cards[2]})/).count === 2)
    )
end

def one_pair?(hand)
  cards = hand.split("").uniq
  cards.length >= 1 && cards.length <= 4 &&
    (
      hand.scan(/(?=#{cards[0]})/).count === 2 ||
      (cards.length > 1 && hand.scan(/(?=#{cards[1]})/).count === 2) ||
      (cards.length > 2 && hand.scan(/(?=#{cards[2]})/).count === 2) ||
      (cards.length > 3 && hand.scan(/(?=#{cards[3]})/).count === 2)
    )
end
