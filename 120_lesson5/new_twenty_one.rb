module Displayable
  def display_welcome_message
    puts "Welcome to Twenty One!"
  end

  def display_game_explanation(points)
    puts "First player to #{points} points is the GRAND MASTER!"
    puts "Hit or stay, but don't go bust!"
  end

  def display_goodbye_message
    puts "Thanks for playing Twenty-one! Goodbye!"
  end

  def clear
    system 'cls'
  end

  def smart_join(arr)
    if arr.size <= 2
      arr.join(' and ')
    else
      arr[0..-2].join(', ') + ", and #{arr[-1]}"
    end
  end

  def display_both_player_hands(user, dealer)
    puts "Your hand: #{smart_join(user.hand)}, dealer: #{dealer.hand.first}."
  end

  def display_user_hand
    puts "#{possesive_pronoun} hand: #{smart_join(hand)}. TOTAL: #{total}."
  end

  def user_bust_message
    puts "You busted! Dealer wins!"
  end

  def display_score(player1, player2)
    puts "Your points: #{player1.points}. Dealer points: #{player2.points}."
  end

  def display_round_winner(player)
    player ? (puts player.win_message) : (puts "It's a tie!")
  end

  def display_grand_master_message(grand_master)
    puts "#{grand_master.first} #{grand_master.last} the GRAND MASTER!!!"
  end

  def display_warning_message
    puts "Be careful! The Dealer is 1 point away from being GRAND MASTER!"
  end
end

module Playable
  def receive_card(player, card)
    player.hand << card
  end

  def hit(cards)
    receive_card(self, cards.shift)
  end

  def convert_face_cards_to_nums(hand)
    face_cards = ['J', 'Q', 'K']
    hand.map { |card| face_cards.include?(card) ? 10 : card }
  end

  def convert_cards_to_integers(hand)
    ranks_only = hand.map(&:rank)
    numbers_hand = convert_face_cards_to_nums(ranks_only)
    if ranks_only.include?('A')
      numbers_hand = transform_hand_with_ace(numbers_hand)
    end
    numbers_hand
  end

  def transform_hand_with_ace(arr)
    count = arr.count('A')
    new_arr = arr.select { |card| card != 'A' }
    change_ace_value(new_arr, count)
  end

  def change_ace_value(arr, count)
    count.times { arr << 1 }
    arr << 10 if arr.sum <= 11
    arr
  end

  def find_total
    self.total = convert_cards_to_integers(hand).sum
  end

  def total_to_s
    "total is #{total}."
  end

  def >(other)
    total > other.total
  end

  def stay
    find_total
    total_to_s
  end

  def bust?
    find_total
    total > 21
  end

  def reach_21?
    find_total
    total == 21
  end
end

class Player
  include Playable
  include Displayable

  attr_reader :name
  attr_accessor :hand, :total, :points

  def initialize(name)
    @name = name
    @hand = []
    @points = 0
  end

  def to_s
    name
  end
end

class User < Player
  def take_turn(deck)
    loop do
      break if reach_21?
      answer = validate_and_return_user_input(answer)
      answer == 'h' ? hit(deck) : break
      break if bust?
    end
    bust? ? user_bust_message : stay
  end

  def validate_and_return_user_input(input)
    valid_responses = ["h", "s"]

    loop do
      puts "Would you like to hit or stay? (h/s)"
      input = gets.chomp.downcase
      break if valid_responses.include?(input)
      puts "Sorry, that's not a valid response."
    end
    input
  end

  def stay
    puts "Your " + super
  end

  def hit(deck)
    super(deck)
    find_total
    display_user_hand
  end

  def possesive_pronoun
    "Your"
  end

  def win_message
    "You win!"
  end
end

class Dealer < Player
  def stay
    puts "#{possesive_pronoun} " + super
  end

  def take_turn(deck)
    find_total
    hit_and_find_total(deck) until total >= 17
    bust? ? (puts "Dealer busted with #{total}!") : stay
  end

  def hit_and_find_total(deck)
    hit(deck)
    find_total
  end

  def possesive_pronoun
    "Dealer's"
  end

  def win_message
    "Dealer wins!"
  end
end

class Card
  attr_reader :suit, :rank

  def initialize(suit, rank)
    @suit = suit
    @rank = rank
  end

  def to_s
    "#{rank} of #{suit}"
  end
end

class Deck
  SUIT = %w(hearts diamonds spades clubs)
  RANK = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A']
  attr_reader :cards

  def initialize
    @cards = []
    SUIT.each do |suit|
      RANK.each do |rank|
        @cards << Card.new(suit, rank)
      end
    end
    @cards.shuffle!
  end
end

class Game
  include Displayable

  MATCH_POINTS = 5

  def initialize
    @user = User.new("You")
    @dealer = Dealer.new("Computer Dealer")
    @shuffled_deck = Deck.new.cards
  end

  def play
    loop do
      introduction
      main_play_loop
      break if !play_again?
      clear
      reset_players_points
      reset_deck
    end
    display_goodbye_message
  end

  private

  attr_reader :user, :dealer
  attr_accessor :shuffled_deck

  def deal_cards
    2.times { user.receive_card(user, @shuffled_deck.shift) }
    2.times { dealer.receive_card(dealer, @shuffled_deck.shift) }
  end

  def reset_players_points
    user.points = 0
    dealer.points = 0
  end

  def reset_deck
    self.shuffled_deck = Deck.new.cards
  end

  def introduction
    clear
    display_welcome_message
    display_game_explanation(MATCH_POINTS)
  end

  def main_play_loop
    loop do
      sleep 2
      main_play_sequence
      break if player_wins_grand_master?
    end
    display_score(user, dealer)
    display_grand_master_message(grand_master)
  end

  def restart_sequence
    sleep 1
    clear
    reset_player_totals
    display_score(user, dealer)
    reset_deck
    user.hand = []
    dealer.hand = []
  end

  def main_play_sequence
    restart_sequence
    display_warning_message if warn_user?
    deal_cards
    display_both_player_hands(user, dealer)
    user.take_turn(shuffled_deck)
    dealer_turn
  end

  def dealer_turn
    if user.bust?
      update_score(dealer)
    else
      dealer.take_turn(shuffled_deck)
      update_score(winner)
      display_round_winner(winner)
    end
  end

  def warn_user?
    (dealer.points == (MATCH_POINTS - 1)) && (user.points != MATCH_POINTS)
  end

  def update_score(player)
    player.points += 1 if player
  end

  def winner
    if dealer.bust? || user > dealer
      user
    elsif dealer > user
      dealer
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Do you want to play again? (y/n)"
      answer = gets.chomp.downcase
      break if ['y', 'n'].include?(answer)
      puts "Sorry, not a valid response."
    end
    answer == 'y'
  end

  def player_wins_grand_master?
    user.points == MATCH_POINTS || dealer.points == MATCH_POINTS
  end

  def grand_master
    return [user, 'are'] if user.points == MATCH_POINTS
    [dealer, 'is']
  end

  def reset_player_totals
    user.total = 0
    dealer.total = 0
  end
end

twenty_one = Game.new
twenty_one.play
