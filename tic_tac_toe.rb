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
#     generate a random number and let the computer chose an empty square to mark its 'O'
#   end
#   display board
#   if computer won
#     announce winner and end game
#   elsif board full?
#     end game
#   end
# end

def draw_board(b)
  puts " #{b[0]} | #{b[1]} | #{b[2]} "
  puts "---+---+---"
  puts " #{b[3]} | #{b[4]} | #{b[5]} "
  puts "---+---+---"
  puts " #{b[6]} | #{b[7]} | #{b[8]} "
end

draw_board ["X", "O", "X", "O", "X", "O", "X", "O", "X"]
