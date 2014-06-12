# black_jack.rb
# Procedural version of BlackJack
require 'pry'

def prompt_user(prompt_string, default_response = "y")
  print "#{prompt_string} (default '#{default_response}')>> "
  response = gets.chomp
  if response.empty?
    response = default_response
  end
  response
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


def display_cards(cards, dealers = false)
  if dealers
    puts "Dealers Cards"
  else
    puts "Your Cards"
  end
  cards.each { print "  -----  " }
  puts

  cards.each { print " |     | " }
  puts

  if dealers
    cards[0,cards.length-1].each { | card | print " |  %c  | " % card.split[0] }
    print " |  X  | "
    puts

    cards[0,cards.length-1].each { | card | print " |  %-2s | " % card.split[1] }
    print " |  X  | "
    puts

  else
    cards.each { | card | print " |  %c  | " % card.split[0] }
    puts

    cards.each { | card | print " |  %-2s | " % card.split[1] }
    puts
  end

  cards.each { print " |     | " }
  puts

  cards.each { print "  -----  " }
  puts
  puts

end


def total(cards)
  values = cards.map {|card| card.split[1]}
  total = 0
  values.each do | value |
    if Array(2..10).include?(value.to_i)
      total += value.to_i
    elsif ["j", "q", "k"].include?(value)
      total += 10
    else # account for all aces later
    end
  end
  # deal only with the aces
  values.count("a").times do
    if total+11 <= 21
      total += 11
    else
      total += 1
    end
  end
  total
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
player = prompt_user("Welcome to the BlackJack table.\nPlease enter your name", "Anon")
new_game = prompt_user("Hi #{player}, are you ready to start a new game? [y/<anything else>]").downcase[0] == 'y'? true : false

while new_game
  number_of_decks = "gibberish"
  until [1, 2, 4, 6, 8].index(number_of_decks)
    number_of_decks = prompt_user("Enter the number of decks you would prefer to play with [1, 2, 4, 6, 8]", "1").to_i
  end

  card_set = initialize_cards(number_of_decks)
  player_cards = []
  dealer_cards = []

  system "cls"
  2.times { player_cards << deal_one_card(card_set) }
  display_cards(player_cards)

  2.times { dealer_cards << deal_one_card(card_set) }
  display_cards(dealer_cards, true)

  puts "Player total = %2d" % total(player_cards)

  if total(player_cards) == 21

    new_game = prompt_user("Hi #{player}, are you ready to start a new game? [y/<any other response>]").downcase[0] == 'y'? true : false

  end

  new_game = prompt_user("Hi #{player}, are you ready to start a new game? [y/<any other response>]").downcase[0] == 'y'? true : false
end



