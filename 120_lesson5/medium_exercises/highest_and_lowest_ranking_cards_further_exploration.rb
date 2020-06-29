class Card
  include Comparable
  attr_reader :rank, :suit, :rank_score
  RANK = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace']
  SUIT = ['Diamonds', 'Clubs', 'Hearts', 'Spades']

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def rank_value
    RANK.index(@rank)
  end

  def suit_value
    SUIT.index(@suit)
  end

  def <=>(other_card)
    if rank_value == other_card.rank_value
      suit_value <=> other_card.suit_value
    else
      rank_value <=> other_card.rank_value
    end
  end

  def to_s
    "#{rank} of #{suit}"
  end
end

cards =  [Card.new('Jack', 'Diamonds'),
         Card.new('Jack', 'Spades')]
puts cards.min == Card.new('Jack', 'Diamonds')
puts cards.max.suit == 'Spades'

cards = [Card.new(8, 'Diamonds'),
         Card.new(8, 'Clubs'),
         Card.new(8, 'Spades')]
puts cards.min
puts cards.max
