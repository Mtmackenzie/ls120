module Playable
  def receive_card(player, card)
    player.hand << card
  end

  def hit
    receive_card(self, Game.shuffled_deck.shift)
  end

  def convert_face_cards_to_nums(hand)
    face_cards = ['J', 'Q', 'K']
    hand.map { |card| face_cards.include?(card) ? 10 : card }
  end

  def convert_cards_to_integers(hand)
    numbers_hand = convert_face_cards_to_nums(hand)
    numbers_hand = transform_hand_with_ace(numbers_hand) if hand.include?('A')
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
    total_to_s
    total > 21
  end
end

class Player
  include Playable

  attr_reader :name
  attr_accessor :hand, :total, :points

  @@all_players = []

  def self.all_players
    @@all_players
  end

  def initialize(name)
    @name = name
    @hand = []
    @points = 0
    @@all_players << self
  end

  def to_s
    name
  end

  def self.list_all_players
    puts "#{all_players.first} vs. #{all_players.last}"
  end

  def smart_join(arr)
    if arr.size <= 2
      arr.join(' and ')
    else
      arr[0..-2].join(', ') + ", and #{arr[-1]}"
    end
  end

  def list_both_player_hands(dealer)
    puts "Your hand: #{smart_join(hand)}, dealer: #{dealer.hand.first}."
  end

  def display_player_hand
    puts "#{possesive_pronoun} hand: #{smart_join(hand)}."
    find_total
    total_to_s
  end
end

class User < Player
  def take_turn
    loop do
      answer = validate_and_return_user_input(answer)
      answer == 'h' ? hit : break
      break if bust?
    end
    bust? ? (puts "You busted! Dealer wins!") : stay
  end

  def validate_and_return_user_input(input)
    valid_responses = ["h", "s"]

    loop do
      puts "Would you like to hit or stay? (h/s)"
      input = gets.chomp
      break if valid_responses.include?(input.downcase)
      puts "Sorry, that's not a valid response."
    end
    input
  end

  def stay
    puts "Your " + super
  end

  def hit
    super
    puts "#{possesive_pronoun} #{display_player_hand}"
  end

  def possesive_pronoun
    "Your"
  end
end

class Dealer < Player
  def stay
    puts "#{possesive_pronoun} " + super
  end

  def take_turn
    find_total
    hit_and_find_total until total >= 17
    bust? ? (puts "Dealer busted with #{total}! You win!") : stay
  end

  def hit_and_find_total
    hit
    find_total
  end

  def possesive_pronoun
    "Dealer's"
  end
end

class Game
  attr_reader :user, :dealer
  MATCH_POINTS = 5

  def initialize
    @user = User.new("You")
    @dealer = Dealer.new("Computer Dealer")
    @@shuffled_deck = []
  end

  def self.shuffled_deck
    @@shuffled_deck
  end

  def shuffle_cards
    cards = []
    (2..10).each { |n| 4.times { cards << n } }
    ['J', 'Q', 'K', 'A'].each { |l| 4.times { cards << l } }
    loop do
      break if cards.empty?
      remaining_indices = (0..cards.size - 1).to_a
      @@shuffled_deck << cards.slice!(remaining_indices.sample)
    end
    @@shuffled_deck
  end

  def display_welcome_message
    puts "Welcome to Twenty-One!"
  end

  def shuffle_deck_and_deal_cards
    shuffle_cards
    Player.all_players.each do |player|
      2.times { player.receive_card(player, @@shuffled_deck.shift) }
    end
  end

  def play
    introduction
    loop do
      main_play_loop
      break if !play_again?
      system 'cls'
      reset_players_points
    end
    display_goodbye_message
  end

  def reset_players_points
    user.points = 0
    dealer.points = 0
  end

  def introduction
    system 'cls'
    display_welcome_message
    Player.list_all_players
  end

  def main_play_loop
    loop do
      main_play_sequence
      break if player_wins_grand_master?
    end
    puts "#{grand_master.first} #{grand_master.last} the GRAND MASTER!!!"
  end

  def main_play_sequence
    puts " ~*~*~*~*~*~*~"
    reset_player_totals
    display_score
    user.hand = []
    dealer.hand = []
    shuffle_deck_and_deal_cards
    user.list_both_player_hands(dealer)
    user.take_turn
    dealer_turn
  end

  def dealer_turn
    if user.bust?
      dealer.points += 1
    else
      dealer.take_turn
      user.points += 1 if dealer.bust?
      determine_outcome unless dealer.bust?
    end
  end

  def determine_outcome
    if user > dealer
      user.points += 1
      puts "You win!"
    elsif dealer > user
      dealer.points += 1
      puts "Dealer wins!"
    else
      puts "Dealer total is #{dealer.total}. It's a tie!"
    end
  end

  def display_score
    puts "Your points: #{user.points}. Dealer points: #{dealer.points}."
  end

  def play_again?
    answer = nil
    loop do
      puts "Do you want to play again? (y/n)"
      answer = gets.chomp.downcase
      break if ['y', 'n'].include?(answer)
      puts "Sorry, not a valid response."
    end
    answer == 'y' ? true : false
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

  def display_goodbye_message
    puts "Thanks for playing Twenty-one! Goodbye!"
  end
end

twenty_one = Game.new
twenty_one.play
