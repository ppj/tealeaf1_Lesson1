# black_jack.rb
# Procedural version of BlackJack
require 'pry'

def prompt_user(prompt_string)
  print "#{prompt_string} >> "
  gets.chomp
end


def initialize_cards(deck_count)
  card_set = []
  deck_count.times do
    # Spade "\u2660", Heart "\u2665", Club "\u2663", Diamond"\u2666"
    ["S", "H", "C", "D"].each do | suite |
      card_set << "#{suite} a"
      (2..10).each do |i|
        card_set << "#{suite} #{i}"
      end
      ["j", "q", "k"].each do | c |
        card_set << "#{suite} #{c}"
      end
    end
  end
  card_set
end


def deal_one_card(cards)
  cards.delete_at(rand(cards.length))
end


def display_cards(cards)
  cards.each { print "  --------  " }
  puts

  2.times do
    cards.each { print " |        | " }
    puts
  end

  cards.each { | card | print " |  %-4s  | " % card }
  puts

  2.times do
    cards.each { print " |        | " }
    puts
  end

  cards.each { print "  --------  " }
  puts

end



# pseudo code
# ask user to enter name

# while user chooses to begin new game
  # give user a choice to choose the number of decks (1, 2, 4, 6, 8)
  # create the deck/s (a data structure to choose the cards from)

  # program (dealer) deals 2 cards to the user (player)
  # add & show player card/s, update player total
  # show dealers card/s (latest card hidden, previous card open), update dealer total

  # if player has a blackjack/ i.e. a total of 21 (face card + ace)

    # if dealer has a blackjack (total of 21)
      # announce push (tie) & end game
    # else
      # announce player as the winner & end game
    # end

  # else (i.e. player does not have blackjack)

    # ## NOT SURE ABOUT THIS STEP ##
    # if dealer has a blackjack (total of 21)
      # announce dealer as the winner & end game
    # end

    # loop
      # ask player to choose to hit or stay
      # deal one card to player
      # add & show player card/s, update player total
      # if player has a blackjack
        # announce player as winner & end game
      # else if player total > 21
        # announce player as loser & end game
      # end
    # end while player chooses to hit

    # while dealer total < 17
      # dealer deals one card to self
      # show dealers card/s (latest card hidden, previous card open), update dealer total
      # if dealer has a blackjack
        # announce dealer as winner & end game
      # else if dealer total > 21
        # announce dealer as loser & end game
      # end
    # end

    # (once out of the above while loop, dealer total >= 17 and < 21) ##
    # if player total > dealer total (& < 21 but no need to check for that)
      # announce player as winner & end game
    # else if player total < dealer total
      # announce dealer as winner & end game
    # else
      # announce push (tie) & end game
    # end
  # end
# end




# main
player = prompt_user("Welcome to the BlackJack table.\nPlease enter your name")
new_game = prompt_user("Hi #{player}, are you ready to start a new game? [y/<anything else>]").downcase[0] == 'y'? true : false

while new_game
  number_of_decks = "gibberish"
  until [1, 2, 4, 6, 8].index(number_of_decks)
    number_of_decks = prompt_user("Enter the number of decks you would prefer to play with [1, 2, 4, 6, 8]").to_i
  end

  card_set = initialize_cards(number_of_decks)
  # binding.pry
  player_cards = []
  dealer_cards = []

  2.times { player_cards << deal_one_card(card_set) }
  display_cards player_cards

  new_game = prompt_user("Hi #{player}, are you ready to start a new game? [y/n]").downcase[0] == 'y'? true : false
end



