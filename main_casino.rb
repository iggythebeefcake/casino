require './cards'
require './deck'

@balance = 0

def main_menu
  puts "~=~=~=~=~= DPL CASINO =~=~=~=~=~ "
  puts "1.) Play"
  puts "2.) Balance"
  puts "3.) Cashout"
  puts "~=~=~=~ Select an option ~=~=~=~ "

  main_choice = gets.strip
  if 
    main_choice == "1"
    game_menu

  elsif
    main_choice == "2"
    balance_menu

  elsif
    main_choice == "3"
    cashout_menu

  else
    puts "Invalid input - to play games, enter '1' with no quotations"
    main_menu

  end

end

def game_menu
  puts "~=~=~=~=~= PLAY GAME =~=~=~=~=~ "
  puts "1.) 21"
  puts "2.) Dice Game"
  puts "3.) Roulette"
  puts "4.) Slots"
  puts "5.) Main menu"
  puts "~=~=~=~ $$ WIN MONEY $$ ~=~=~=~ "

  game_choice = gets.strip
  if 
    game_choice == "1"
    new_game_twentyone

  elsif
    game_choice == "2"
    dice_game

  elsif
    game_choice == "3"
    roulette_bet

  elsif
    game_choice == "4"
    start_slots

  elsif
    game_choice =="5"
    main_menu

  else
    puts "Invalid input - to return to main menu, enter '4' with no quotations"
    game_menu

  end

end

def balance_menu
  puts "~=~=~=~=~= DPL CASINO =~=~=~=~=~ "
  puts "Current balance: $#{@balance}"
  puts "1.) Add funds"
  puts "2.) Main menu"
  puts "~=~=~=~ $$ WIN MONEY $$ ~=~=~=~ "

  balance_choice = gets.strip
  if
    balance_choice == "1"
    puts "How much do you want to deposit? (Dollar bills only - no change accepted.)"
    deposit = gets.to_i
    if 
      deposit <= 0
      puts "Invalid input - enter a positive amount."
      balance_menu
    elsif
      deposit < 25
      puts "No low rollers - deposit at least $25."
      balance_menu
    elsif
      deposit > 100000
      puts "For legal reasons, we can not accept deposits over $100,000."
      balance_menu

    else
      puts "You have successfully deposited $#{deposit}."
      @balance += deposit
      puts "Your balance is now $#{@balance}"
      balance_menu
    end

  elsif
    balance_choice == "2"
    main_menu
  else
    puts "Invalid input - try again"
    balance_menu
  end
end

def cashout_menu
  puts "~=~=~=~=~= DON'T LEAVE =~=~=~=~=~ "
  puts "Current balance: $#{@balance}"
  puts "Are you sure you want to go? (y/n)"
  puts "~=~=~=~ GAMBLE YOUR HEART OUT ~=~=~=~ "
  final_input = gets.strip
  if
    final_input == "y"
    puts "See you next time!"
    exit
  else
    puts "Welcome back!"
    main_menu
  end
end

########################### Twentyone

def new_game_twentyone
  fresh_deck = Deck.new
  @shuffled_deck = fresh_deck.shuffle_cards
  @count = 0
  @player_hand = []
  @dealer_hand = []
  @player_score = 0
  @dealer_score = 0
  @bet = 0

  puts "~=~=~=~=~= NEW GAME ~=~=~=~=~="
  puts "Place your bet!"
  puts "Your current balance is $#{@balance}"
  player_bet = gets.to_i

  if 
    player_bet > @balance
    puts "You can not bet more than your balance ($#{@balance})"
    puts "Enter r to return to the main menu"
    puts "Enter b to go to the balance menu"
    puts "Enter p to place a new bet"

    bet_menu_input = gets.strip
    if
      bet_menu_input == "r"
      main_menu
    elsif
      bet_menu_input == "b"
      balance_menu
    elsif
      bet_menu_input =="p"
      new_game_twentyone
    else
      puts "Invalid input - rerouting you to main menu."
      main_menu
    end
  else
    @bet = player_bet
    @balance -= player_bet
    puts ''
    puts "You bet $#{@bet}"

  end

  initial_deal_twentyone

end

def initial_deal_twentyone
  puts "The cards are dealt!"
  puts ''
  puts "You have the #{@shuffled_deck[-1].rank} of #{@shuffled_deck[-1].suit} and the #{@shuffled_deck[-2].rank} of #{@shuffled_deck[-2].suit}"
  @player_hand << @shuffled_deck[-1]
  @player_hand << @shuffled_deck[-2]
  player_hand_counter_twentyone(-1)
  player_hand_counter_twentyone(-2)
  puts "Your score is #{@player_score}"
  puts ''

  puts "The dealer shows #{@shuffled_deck[-3].rank} of #{@shuffled_deck[-3].suit} and has one card face down."
  puts ''
  @dealer_hand << @shuffled_deck[-3]
  @dealer_hand << @shuffled_deck[-4]
  dealer_hand_counter_twentyone(-3)
  dealer_hand_counter_twentyone(-4)

  player_twentyone

end

def player_hand_counter_twentyone(i)
  if 
    @shuffled_deck[i].rank == "A"
    @player_score += 11

  elsif
    @shuffled_deck[i].rank == "J" or 
    @shuffled_deck[i].rank == "Q" or 
    @shuffled_deck[i].rank == "K"
    @player_score += 10

  else
    @player_score += @shuffled_deck[i].rank.to_i

  end
end

def dealer_hand_counter_twentyone(i)
  if 
    @shuffled_deck[i].rank == "A"
    @dealer_score += 11

  elsif
    @shuffled_deck[i].rank == "J" or 
    @shuffled_deck[i].rank == "Q" or 
    @shuffled_deck[i].rank == "K"
    @dealer_score += 10

  else
    @dealer_score += @shuffled_deck[i].rank.to_i

  end
end

def draw_card_dealer_twentyone
  puts "The dealer draws the #{@shuffled_deck[@count].rank} of #{@shuffled_deck[@count].suit}."
  puts ''
  @dealer_hand << @shuffled_deck[@count]
  dealer_hand_counter_twentyone(@count)
  @count  += 1
  end

def player_twentyone
  puts "Enter d to draw, s to stand, h to view cards."
  input = gets.strip
  if input == "d"
    puts "You draw the #{@shuffled_deck[@count].rank} of #{@shuffled_deck[@count].suit}."
    # Push card into player hand
    @player_hand << @shuffled_deck[@count]

    player_hand_counter_twentyone(@count)

    @count  += 1

    if @player_score == 21
      puts "You made 21!"
      winnings_twentyone
    elsif
      @player_score > 21
      bust_twentyone
    else
      player_twentyone
    end

  elsif
    input == "s"
    dealer_twentyone

  elsif
    input == "h"
    display_player_hand_twentyone
  else
    "Inavlid input"
    player_twentyone
  end
  puts ''
end

def display_player_hand_twentyone
  puts "You are holding the following cards:"
  for player_card in @player_hand
    puts "#{player_card.rank} of #{player_card.suit} "
  end
  puts "Your current score is #{@player_score}"
  player_twentyone
end

def dealer_twentyone
  if @dealer_score >= 17
    count_scores_twentyone

  else
    draw_card_dealer_twentyone
    dealer_twentyone

  end
end

def bust_twentyone
  puts "You went over 21!"
  show_all_cards_twentyone
  one_more_game
end

def count_scores_twentyone
  show_all_cards_twentyone
  if @dealer_score > 21
    puts "The dealer busts!"
    winnings_twentyone

  elsif
    @player_score > @dealer_score
    puts "You win with a score of #{@player_score}! The dealer had a score of #{@dealer_score}."
    winnings_twentyone

  elsif @player_score == @dealer_score
    puts "You tied with the dealer. You get your bet of $#{@bet} back."
    @balance += @bet

  else
    puts "The dealer wins with a score of #{@dealer_score}, beating your score of #{@player_score}."
  end
  one_more_game
end

def winnings_twentyone
  @balance += (2 * @bet)
  puts "You win your bet of $#{@bet}, increasing your balance to $#{@balance}"
  one_more_game
end

def one_more_game
  puts "Play again? (y/n)"
  another_round = gets.strip
  if another_round == "y"
    puts ''
    new_game_twentyone
  else
    puts ''
    main_menu
  end
end

def show_all_cards_twentyone
  puts "Your hand was"
  for player_card in @player_hand
    puts "#{player_card.rank} of #{player_card.suit} "
  end
  puts "with a score of #{@player_score}."
  puts''

  puts "The dealer's hand was"
  for dealer_card in @dealer_hand
    puts "#{dealer_card.rank} of #{dealer_card.suit} "
  end
  puts "with a score of #{@dealer_score}."
  puts ''

end

########################### Roulette

def roulette_bet
  @bet = 0
@bet_odds = 1
  puts "~=~=~=~=~= NEW GAME ~=~=~=~=~="
  puts "Place your bet!"
  puts "Your current balance is $#{@balance}"
  player_bet = gets.to_i
  @bet = player_bet
  @balance -= player_bet
  puts "You bet $#{@bet}"

  roulette_menu

end

def roulette_menu

  puts "How will you bet?"
  puts "1. Single number"
  puts "2. Even or Odd"
  puts "3. High/Low"
  player_input = gets.to_i

  if
    player_input == 1
    single_number_roulette

  elsif
    player_input == 2
    even_odd_roulette

  elsif
    player_input == 3
    low_high_roulette

  else
    puts "Invalid input - try again"
    roulette_menu

  end

end

def single_number_roulette
  puts "What number do you think the wheel will land on? (1 - 36)"
  @player_guess_roulette = gets.to_i
  if @player_guess_roulette > 36 or @player_guess_roulette < 1
    puts "Choose a whole number between 1 and 36."
    single_number_roulette
  else
    puts "You guess #{@player_guess_roulette}"
  end

  spin_wheel_roulette
  @bet_odds = 35
 
  if @roulette_ball == @player_guess_roulette
    winnings = (@bet_odds * @bet)
    puts "The ball landed on #{@roulette_ball}, you win $#{winnings}!"
    @balance += winnings
    puts winnings
    puts @balance

  else
    puts "The ball landed on #{@roulette_ball}, you lose this time."
  end

  play_roulette_again

end

def even_odd_roulette
  puts "Where will the ball land, even or odd?"
  @player_guess_roulette = gets.strip
  if @player_guess_roulette == "even"
    puts "You guess even."
    even_odd = 0
  elsif
    @player_guess_roulette == "odd"
    puts "You guess odd."
    even_odd = 1
  else
    puts "Invalid input - enter 'even' or 'odd' (no quotes)."
    even_odd_roulette
  end
  
  spin_wheel_roulette
  @bet_odds = 2

  if @roulette_ball % 2 == even_odd
    winnings = (@bet_odds * @bet)
    puts "The ball landed on #{@roulette_ball}, an #{@player_guess_roulette} number. You win $#{winnings}!"
    @balance += winnings

  else
    puts "The ball landed on #{@roulette_ball}, you lose this time."
  end
  
  play_roulette_again
  
end

def low_high_roulette
  puts "Where will the ball land, high or low?"
  @player_guess_roulette = gets.strip
  if @player_guess_roulette == "high"
    puts "You guess high."
    high_low_guess = 1
  elsif
    @player_guess_roulette == "low"
    puts "You guess low."
    even_odd_guess = 0
  else
    puts "Invalid input - enter 'high' or 'low' (no quotes)."
    low_high_roulette
  end
  
  spin_wheel_roulette
  @bet_odds = 2
  winnings = (@bet_odds * @bet)

  if @roulette_ball > 18
    high_low_actual = 1

  else
    high_low_actual = 0

  end

  if high_low_guess == high_low_actual
    puts "The ball landed on #{@roulette_ball}, your guess of #{@player_guess_roulette} was correct! You win #{winnings}"
    @balance += winnings
  else
    puts "The ball landed on #{@roulette_ball}, your guess of #{@player_guess_roulette} was incorrect. Better luck next time!"
  end
  
  play_roulette_again

end

def spin_wheel_roulette
@roulette_ball = (1 + rand(36))
end

def play_roulette_again
  puts "Do you want to play more roulette? (y/n)"
  another_round = gets.strip
  if another_round == "y"
    roulette_bet
  else
    main_menu
  end
end

######################## Slots

@slot_items = ["APPLES", "ORANGES"]

def start_slots
  puts "    
 Let's play APPLES and ORANGES!

          .-------.
       .=============.
       | [a] [a] [o] | __
       | [$] [$] [$] |(  )
       | [o] [o] [a] | ||
       |             | ||
       | aaa ::::::: |_||
       | ooo ::::::: |__'
       | $$$ ::::::: |
       |             |
       |      __ === |
       |_____|__|____|
      |###############|
     |#################|
    |___________________|
    
---Feeling lucky? Type 'Y' to pull the lever.---\n        ---Or type 'N' to go back.---\n\n"

lever_option
end

def lever_option
lever_pull = gets.strip.upcase
  if lever_pull == "Y"
    puts "How much will you bet?"
    @bet = gets.to_i
    if @bet > @balance
      puts "You can't bet more than your balance!"
      puts "Rerouting you to balance menu..."
      balance_menu
    elsif
      @bet < 0
      puts "Invalid bet amount"
      start_slots
    else
    @balance -= @bet
    puts "You bet $#{@bet}"
    run_slot_1
    end
  elsif lever_pull == "N"
    puts "You can't win what you don't put down!"
    main_menu
  else 
    puts "Invalid response. Please try again."
    start_slots
  end
end


def run_slot_1
  puts "Nice pull! Waiting for slot one... \n"
    sleep(4)
  slot1 = @slot_items.sample
  puts "Slot one returned #{slot1}! \n"
    sleep(1)
  puts "Waiting for slot two... \n"
    sleep(5)
  # run_slot_2
  slot2 = @slot_items.sample
  puts "Slot two returned #{slot2}!"
  # slot_checker
    if slot1 == slot2
      puts "Congratulations! You got a winning combination of #{slot1} and #{slot2}. You win $#{@bet}"
      @balance += (2 * @bet)
    else
      puts "Awe, your slots didn't match this time. Try again to win your money back!"
    end
    start_slots
end

###################### Dice game

def dice_game

  puts 'Let\'s play dice, ya\'ll!'
    puts "Place your bet! You have #{@balance} chips left!"
    @bet = gets.chomp
    while true
      if (@balance.to_i - @bet.to_i) < 0
        puts 'You don\'t have that many chips! Try again.'
        @bet = gets.chomp
      else
        break
      end
    end
    if @bet.to_i > 5
      puts @bet.to_s + '?! You high rollin.'
      puts 'I\'ll roll two dice. What do you think the total will be?'
    else
      puts @bet.to_s + '?! Just that much.'
      puts 'I\'ll roll two dice. What do you think the total will be?'
    end
    total = gets.chomp
    dice_total = ((1 + rand(6))+(1 + rand(6)))
    print 'The total was ' + dice_total.to_s + '! '
    if dice_total.to_i == total.to_i
      @balance = @balance.to_i + @bet.to_i
      puts 'You win! Nice job!'
    else
      @balance = @balance.to_i - @bet.to_i
      puts 'Not this time, my friend!'
    end

  main_menu

  
  end
  

main_menu



