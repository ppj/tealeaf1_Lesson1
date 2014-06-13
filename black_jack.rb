# black_jack.rb
# Procedural version of dealer vs. one player BlackJack
# require 'pry'

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

    # ask player to choose to hit or stay
    # while player chooses to hit
      # deal one card to player
      # add & show player card/s, update player total
      # if player has a blackjack
        # announce player as winner & end game
      # else if player total > 21
        # announce player as loser & end game
      # else
        # ask player to choose to hit or stay
      # end
    # end

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





def prompt_user(prompt_string, default_response = "y")
  print "#{prompt_string} (default '#{default_response}')>> "
  response = gets.chomp
  if response.empty?
    response = default_response
  end
  response
end


def initialize_cards(deck_count)
  # Spade "\u2660", Heart "\u2665", Club "\u2663", Diamond"\u2666"
  card_set = ["\u2660", "\u2665", "\u2663", "\u2666"].product(["a", Array(2..10), "j", "q", "k"].flatten) * deck_count
end


def deal_one_card(cards)
  cards.delete_at(rand(cards.length))
end


def display_cards(cards, header = "Your Cards", hide_last = false)
  puts header

  cards.each { print "  -----  " }
  puts

  cards.each { print " |     | " }
  puts

  if hide_last
    cards[0,cards.length-1].each { | card | print " |  #{card[0]}  | " }
    print " |  X  | "
    puts

    cards[0,cards.length-1].each { | card | print " |  %-2s | " % card[1] }
    print " |  X  | "
    puts

  else
    cards.each { | card | print " |  #{card[0]}  | " }
    puts

    cards.each { | card | print " |  %-2s | " % card[1] }
    puts
  end

  cards.each { print " |     | " }
  puts

  cards.each { print "  -----  " }
  unless hide_last
    print "  Total: #{total(cards)}"
  end
  puts
  puts

end


def total(cards)
  values = cards.map {|card| card[1]}
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


def display(pcards, dcards, game_over_msg = "" )
  system "cls"
  display_cards(dcards, "My Cards", game_over_msg.empty?)
  display_cards(pcards)
  unless game_over_msg.empty?
    puts game_over_msg
    puts "### GAME OVER ###\n\n"
  end
end


# main
player = prompt_user("Welcome to the BlackJack table.\nYour name please", "Alex")

new_game = prompt_user("Hi #{player}, are you ready to start a new game? [y/<anything else>]").downcase[0]

while new_game == 'y'

  number_of_decks = "gibberish"
  until [1, 2, 4, 6, 8].index(number_of_decks)
    number_of_decks = prompt_user("Enter the number of decks you would prefer to play with [1, 2, 4, 6, 8]", "4").to_i
  end

  card_set = initialize_cards(number_of_decks)
  player_cards = []
  dealer_cards = []

  # initial dealing
  2.times { player_cards << deal_one_card(card_set) }
  2.times { dealer_cards << deal_one_card(card_set) }

  display(player_cards, dealer_cards)

  # if player gets a blackjack after the initial dealing
  if total(player_cards) == 21
    display(player_cards, dealer_cards, "You hit a BlackJack! You win #{player}!!")
    if total(dealer_cards) == 21
      display(player_cards, dealer_cards, "Game pushes")
    end
  else
    game_over = false

    # player's turn
    hit = prompt_user("Would you like to hit or stay, #{player}? [h/s]", "h").downcase[0]
    while hit == 'h'
      player_cards << deal_one_card(card_set)
      display(player_cards, dealer_cards)
      if total(player_cards) > 21
        hit = "s"
        game_over = true
        display(player_cards, dealer_cards, "You have busted. I win!")
      elsif total(player_cards) == 21
        hit = "s"
        game_over = true
        if total(dealer_cards) == 21
          display(player_cards, dealer_cards, "Game pushes")
        else
          display(player_cards, dealer_cards, "You hit a BlackJack! You win #{player}!!")
        end
      else
        hit = prompt_user("Would you like to hit or stay, #{player}? [h/s]", "h").downcase[0]
      end
    end

    # dealer's turn
    unless game_over
      while total(dealer_cards) < 17
        dealer_cards << deal_one_card(card_set)
        display(player_cards, dealer_cards)
        if total(dealer_cards) > 21
          game_over = true
          display(player_cards, dealer_cards, "I have busted. You win #{player}!")
        elsif total(dealer_cards) == 21
          game_over = true
          display(player_cards, dealer_cards, "I hit a BlackJack!! I win!!!")
        end
      end
    end

    # if no winner / loser yet
    unless game_over
      if total(player_cards) > total(dealer_cards)
        game_over = true
        display(player_cards, dealer_cards, "I lose. You win #{player}!")
      elsif total(player_cards) == total(dealer_cards)
        game_over = true
        display(player_cards, dealer_cards, "Game pushed! Nobody loses!!")
      else
        game_over = true
        display(player_cards, dealer_cards, "I win! You lose #{player}!!")
      end
    end

  end

  new_game = prompt_user("Enter 'y' when you are ready to start a new game, #{player}? [y/<any other response>]").downcase[0]

end
