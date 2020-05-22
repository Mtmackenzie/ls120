# Nobility
# Now that we have a Walkable module, we are given a new challenge. Apparently some of our users are nobility, and the regular way of walking simply isn't good enough. Nobility need to strut.
# We need a new class Noble that shows the title and name when walk is called:

module Walkable
  def walk
    "#{name} #{gait} forward."
  end
end

class Noble
  attr_reader :name, :title
  include Walkable
  def initialize(name, title)
    @name = name
    @title = title
  end

  def walk
    "#{title} " + super
  end

  def gait
    "struts"
  end
end

byron = Noble.new("Byron", "Lord")
puts byron.walk
p byron.name
#=> "Byron"
p byron.title
#=> "Lord"