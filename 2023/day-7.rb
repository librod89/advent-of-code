## Usage: ruby day-7.rb <path to file>

require_relative "day-7/hand-types"
require_relative "day-7/merge-sort"

HAND_TYPES = {
  five_of_a_kind: 7,
  four_of_a_kind: 6,
  full_house: 5,
  three_of_a_kind: 4,
  two_pair: 3,
  one_pair: 2,
  high_card: 1
}

def run(file, version)
  @hands = {}
  @version = version
  File.open(file).each_with_index do |line, index|
    hand, bid = line.split(" ").map(&:strip)
    @hands[index] = { hand: hand, bid: bid.to_i}
  end

  find_hand_types
  @hands.each { |_, hand| find_best_with_joker(hand) } if @version > 1
  calculate_rank
  calculate_winnings
end

def find_hand_types
  @hands.each do |_, hand|
    if five_of_a_kind?(hand[:hand])
      hand.merge!({ type: :five_of_a_kind})
    elsif full_house?(hand[:hand])
      hand.merge!({ type: :full_house})
    elsif four_of_a_kind?(hand[:hand])
      hand.merge!({ type: :four_of_a_kind})
    elsif three_of_a_kind?(hand[:hand])
      hand.merge!({ type: :three_of_a_kind})
    elsif two_pair?(hand[:hand])
      hand.merge!({ type: :two_pair})
    elsif one_pair?(hand[:hand])
      hand.merge!({ type: :one_pair})
    else
      hand.merge!({ type: :high_card})
    end
  end
end

def find_best_with_joker(hand)
  joker_count = hand[:hand].scan(/(?=J)/).count
  hand_without_jokers = hand[:hand].scan(/[^J]/).join('')
  if joker_count === 4
    hand[:type] = :five_of_a_kind
  elsif joker_count === 3
    return hand[:type] = :five_of_a_kind if one_pair?(hand_without_jokers)
    hand[:type] = :four_of_a_kind # high_card
  elsif joker_count === 2
    return hand[:type] = :five_of_a_kind if hand[:type] === :full_house
    return hand[:type] = :four_of_a_kind if one_pair?(hand_without_jokers)
    hand[:type] = :three_of_a_kind # high_card
  elsif joker_count === 1
    return hand[:type] = :five_of_a_kind if hand[:type] === :four_of_a_kind
    return hand[:type] = :four_of_a_kind if hand[:type] === :three_of_a_kind
    return hand[:type] = :full_house if two_pair?(hand[:hand])
    return hand[:type] = :three_of_a_kind if one_pair?(hand_without_jokers)
    hand[:type] = :one_pair # high_card
  else
    # noop
  end
end

def calculate_rank
  rank = 1
  @hands.sort_by{ |_, hand| HAND_TYPES[hand[:type]] }.each do |_, hand|
    next if hand.key?(:rank)

    tied_hands = @hands.filter{ |_, h| h[:type] === hand[:type] }
    if tied_hands.length === 1
      hand.merge!({ rank: rank })
      rank += 1
    else
      merge_sort(tied_hands.keys, @version).each do |key|
        tied_hands[key].merge!({ rank: rank })
        rank += 1
      end
    end
  end
end

def calculate_winnings
  total = 0
  @hands.each do |_, hand|
    total += hand[:bid] * hand[:rank]
  end
  total
end

if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

puts "::::::::::::::::: Part 1 :::::::::::::::::"
puts run(ARGV[0], 1)

puts "::::::::::::::::: Part 2 :::::::::::::::::"
puts run(ARGV[0], 2)
