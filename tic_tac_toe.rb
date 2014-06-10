# tic_tac_toe.rb
require 'pry'

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
#     generate a random number and let the computer chose an empty square to mark its 'O'
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

def draw_display_board(b)
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

def board_full?(b)
  return b.select {|e| e != " " }.length == 9
end

def check_winner(b, symbol)
  winning_patterns = [
    [1, 2, 3],
    [1, 4, 7],
    [1, 5, 9],
    [2, 5, 8],
    [3, 6, 9],
    [4, 5, 6],
    [7, 8, 9]
  ]

  winning_patterns.each do |pattern|
    if symbol == b[pattern[0]-1] and
       symbol == b[pattern[1]-1] and
       symbol == b[pattern[2]-1]
      puts "Player #{symbol} won. Game Over!"
      return true
    end
  end
  false

end

board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

until board_full?(board)
  system "cls"
  puts
  valid_user_input = false
  until valid_user_input
    draw_display_board board
    position = prompt "Select one of empty (numbered) positions above to put an 'X' in"
    position = position.to_i - 1
    if board[position] == " "
      valid_user_input = true
      board[position] = "X"
    end
  end
  # stop if player "X" won
  if check_winner(board, "X")
    draw_board board
    break
  end

  computer_options = []
  board.each_with_index {|e, idx| computer_options << idx if e == " " }
  computer_option = computer_options.sample
  if computer_option
    board[computer_option] = "O"
  end
  # stop if player "O" won
  if check_winner(board, "O")
    draw_board board
    break
  end
  if board_full?(board)
    puts "Game Tied! No winner."
  end
  draw_board board
end

# draw_board ["X", "O", "X", "O", "X", "O", "X", "O", "X"]

