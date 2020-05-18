class Person
  attr_accessor :name

  def initialize(n)
    @name = n
  end

  def hi
    "Hi, #{@name}"
  end
end

bob = Person.new("Bob")
p bob.hi

