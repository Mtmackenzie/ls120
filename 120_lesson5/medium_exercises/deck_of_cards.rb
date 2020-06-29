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

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
puts drawn.count { |card| card.rank == 5 } == 4
puts drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
puts drawn2.count { |card| card.rank == 5 } == 4
puts drawn2.count { |card| card.suit == 'Hearts' } == 13

drawn3 = []
5.times { drawn3 << deck.draw }
puts (drawn3.max.rank - drawn3.min.rank)
# puts drawn != drawn2