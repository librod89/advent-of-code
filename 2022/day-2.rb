
## Usage: ruby day-2.rb <path to file>

OPPONENT_ROCK = "A"
OPPONENT_PAPER = "B"
OPPONENT_SCISSORS = "C"

MY_ROCK = "X"
MY_PAPER = "Y"
MY_SCISSORS = "Z"

OUTCOME_LOSE = "X"
OUTCOME_DRAW = "Y"
OUTCOME_WIN = "Z"

ROCK_POINT = 1
PAPER_POINT = 2
SCISSORS_POINT = 3

DRAW_POINT = 3
WIN_POINT = 6
LOSE_POINT = 0

def play_v1(file)
  points = 0
  File.open(file).each do |line|
    choices = line.strip.split(' ')
    opponent_play = choices[0]
    my_play = choices[1]
    case opponent_play
    when OPPONENT_ROCK
      case my_play
      when MY_ROCK
        points += ROCK_POINT + DRAW_POINT
      when MY_PAPER
        points += PAPER_POINT + WIN_POINT
      when MY_SCISSORS
        points += SCISSORS_POINT + LOSE_POINT
      end
    when OPPONENT_PAPER
      case my_play
      when MY_ROCK
        points += ROCK_POINT + LOSE_POINT
      when MY_PAPER
        points += PAPER_POINT + DRAW_POINT
      when MY_SCISSORS
        points += SCISSORS_POINT + WIN_POINT
      end
    when OPPONENT_SCISSORS
      case my_play
      when MY_ROCK
        points += ROCK_POINT + WIN_POINT
      when MY_PAPER
        points += PAPER_POINT + LOSE_POINT
      when MY_SCISSORS
        points += SCISSORS_POINT + DRAW_POINT
      end
    end
  end

  points
end

def play_v2(file)
  points = 0
  File.open(file).each do |line|
    choices = line.strip.split(' ')
    opponent_play = choices[0]
    outcome = choices[1]
    case opponent_play
    when OPPONENT_ROCK
      case outcome
      when OUTCOME_WIN
        points += PAPER_POINT + WIN_POINT
      when OUTCOME_LOSE
        points += SCISSORS_POINT + LOSE_POINT
      when OUTCOME_DRAW
        points += ROCK_POINT + DRAW_POINT
      end
    when OPPONENT_PAPER
      case outcome
      when OUTCOME_WIN
        points += SCISSORS_POINT + WIN_POINT
      when OUTCOME_LOSE
        points += ROCK_POINT + LOSE_POINT
      when OUTCOME_DRAW
        points += PAPER_POINT + DRAW_POINT
      end
    when OPPONENT_SCISSORS
      case outcome
      when OUTCOME_WIN
        points += ROCK_POINT + WIN_POINT
      when OUTCOME_LOSE
        points += PAPER_POINT + LOSE_POINT
      when OUTCOME_DRAW
        points += SCISSORS_POINT + DRAW_POINT
      end
    end
  end

  points
end

if ARGV[0].nil?
  puts "Missing path to input file"
  exit 0
end

puts "::::::::::::::::: V1 :::::::::::::::::"
puts play_v1(ARGV[0])

puts "::::::::::::::::: V2 :::::::::::::::::"
puts play_v2(ARGV[0])
