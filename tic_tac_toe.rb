# tic_tac_toe.rb

# psuedo code
# Start with an empty 3x3 board
# until board full or winner
#   ask player to chose empty square to mark his/her 'X'
#   display board
#   if player won?
#     announce winner and end game
#   else if board full?
#     end game
#   else
#     generate a random number and let the computer choose an empty square to mark its 'O'
#   end
#   display board
#   if computer won
#     announce winner and end game
#   elsif board full?
#     end game
#   end
# end


def prompt(prompt_string)
  print prompt_string + ": "
  gets.chomp
end


def initialize_board
  b = []
  9.times {b << " "}
  b
end


def draw_helper_board(b)
  display = []
  b.each_with_index do |e, idx|
    if e == " "
      display << idx+1
    else
      display << e
    end
  end
  draw_board display
end


def draw_board(b)
  puts " #{b[0]} | #{b[1]} | #{b[2]} "
  puts "---+---+---"
  puts " #{b[3]} | #{b[4]} | #{b[5]} "
  puts "---+---+---"
  puts " #{b[6]} | #{b[7]} | #{b[8]} "
end


def empty_positions(b)
  positions = []
  b.each_with_index {|e, idx| positions << idx if e == " " }
  positions
end


def board_full?(b)
  empty_positions(b).length == 0
end


def check_winner(b, symbol)
  winning_patterns = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
    [1, 4, 7],
    [2, 5, 8],
    [3, 6, 9],
    [1, 5, 9],
    [3, 5, 7]
  ]

  if empty_positions(b).length > 4
    return false
  end

  winning_patterns.each do |pattern|
    if symbol == b[pattern[0]-1] and
       symbol == b[pattern[1]-1] and
       symbol == b[pattern[2]-1]
      return true
    end
  end
  false
end


def player_plays(b)
  valid_user_input = false
  until valid_user_input
    draw_helper_board b # helper board for user
    position = prompt "Select one of empty (numbered) positions above to put an 'X' in"
    position = position.to_i - 1
    if b[position] == " "
      valid_user_input = true
      b[position] = "X"
    end
  end
  b
end


def computer_plays(b)
  computer_option = empty_positions(b).sample
  if computer_option
    b[computer_option] = "O"
  end
end

# main
board = initialize_board

until board_full?(board)
  system "cls"
  puts
  player_plays board # pass by reference changes the contents of board
  # stop if player "X" won
  if check_winner(board, "X")
    puts "You won!"
    draw_board board
    puts "Game Over!"
    break
  end

  computer_plays board
  # stop if player "O" won
  if check_winner(board, "O")
    puts "Computer won!"
    draw_board board
    puts "Game Over!"
    break
  end
  if board_full?(board)
    puts "It's a tie. No winner."
    puts "Game Over!"
  end
  draw_board board
end

