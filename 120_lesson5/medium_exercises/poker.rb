# class Card
#   include Comparable
#   attr_reader :rank, :suit

#   VALUES = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }

#   def initialize(rank, suit)
#     @rank = rank
#     @suit = suit
#   end

#   def to_s
#     "#{rank} of #{suit}"
#   end

#   def value
#     VALUES.fetch(rank, rank)
#   end

#   def <=>(other_card)
#     value <=> other_card.value
#   end
# end

class Card
  include Comparable
  attr_reader :rank, :suit
  RANK = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace']

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def value
    RANK.index(@rank)
  end

  def <=>(other_card)
    value <=> other_card.value
  end

  def to_s
    "#{rank} of #{suit}"
  end
end

class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze
  attr_reader :shuffled_cards

  def initialize
    @all_cards = []
    @shuffled_cards = nil
    generate_card_set
    shuffle
  end

  def generate_card_set
    SUITS.each do |suit|
      RANKS.each do |rank|
        @all_cards << Card.new(rank, suit)
      end
    end
  end

  def shuffle
    @shuffled_cards = @all_cards.shuffle
  end

  def draw
    if @shuffled_cards.empty?
      shuffle
      @shuffled_cards.pop
    else
      @shuffled_cards.pop
    end
  end
end

class PokerHand
  def initialize(deck)
    @hand = []
    5.times { @hand << deck.draw }
  end

  def print
    printable_hand = @hand.map { |card| card.to_s }.join(', ')
    puts "Hand is #{printable_hand}."
  end

  def evaluate
    @number_hand = @hand.map { |card| card.value}
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  def royal_flush?
    flush? && straight? && @hand.min.rank == 10
  end

  def straight_flush?
    flush? && straight?
  end

  def four_of_a_kind?
    @hand.each do |card|
      rank = card.rank
      return true if @hand.count { |card| card.rank == rank } == 4
    end
    false
  end

  def full_house?
    three_of_a_kind? && pair?
  end

  def flush?
    @hand.each do |card|
      suit = card.suit
      return true if @hand.count { |card| card.suit == suit } == 5
    end
    false
  end

  def straight?
    @hand.each do |card|
      rank = card.rank
      return false if @hand.count { |card| card.rank == rank } > 1
    end
    (@hand.max.value - @hand.min.value) == 4
  end

  def three_of_a_kind?
    @hand.each do |card|
      rank = card.rank
      return true if @hand.count { |card| card.rank == rank } == 3
    end
    false
  end

  def two_pair?
    ranks = []
    pair_count = 0
    @hand.each do |card|
      ranks << card.rank
    end
    ranks_copy = ranks.clone
    ranks_copy.uniq.each { |rank| pair_count += 1 if ranks.count(rank) == 2}
    pair_count == 2
  end

  def pair?
    @hand.each do |card|
      rank = card.rank
      return true if @hand.count { |card| card.rank == rank } == 2
    end
    false
  end
end
# Testing your class:

# hand = PokerHand.new(Deck.new)
# hand.print
# puts hand.evaluate

# # Danger danger danger: monkey patching for testing purposes.
class Array
  alias_method :draw, :pop
end

# # Test that we can identify each PokerHand type.
hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts hand.evaluate == 'Royal flush'

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new('Queen', 'Clubs'),
  Card.new('King',  'Diamonds'),
  Card.new(10,      'Clubs'),
  Card.new('Ace',   'Hearts'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'
