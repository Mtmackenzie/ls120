# Given the below usage of the Person class, code the class definition.
# class Person
#   attr_accessor :name
#   def initialize(name)
#     @name = name
#   end
# end

class Person
  
  def initialize(name)
    @name = name
  end

  def name
    @name
  end

  def name=(n)
    @name = n
  end

end

bob = Person.new('bob')
bob.name                  # => 'bob'
bob.name = 'Robert'
p bob.name                  # => 'Robert'