# Using the class definition from step #3, let's create a few more people -- that is, Person objects.
class Person
  attr_accessor :first_name, :last_name
  def initialize(name)
    split_names(name)
  end

  def name
    [first_name, last_name].join(' ')
  end

  def name=(name)
    split_names(name)
  end

  private

  def split_names(name)
    @first_name = name.split[0]
    name.split.size > 1 ? @last_name = name.split[1] : @last_name = ''
  end

end

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')
# If we're trying to determine whether the two objects contain the same name, how can we compare the two objects?

puts bob == rob
puts bob.name == rob.name