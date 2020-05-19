# Modify the class definition from above to facilitate the following methods. Note that there is no name= setter method now.

class Person
  attr_accessor :name, :last_name

  def initialize(name)
    @name = name
    @last_name = ''
  end

  def first_name
    @name
  end

  def last_name=(last_name)
    @last_name = last_name
  end

  def name
    "#{first_name} #{last_name}"
  end
end


bob = Person.new('Robert')
bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
p bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'
# Hint: let first_name and last_name be "states" and create an instance method called name that uses those states.