# Now create a smart name= method that can take just a first name or a full name, and knows how to set the first_name and last_name appropriately.

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

bob = Person.new('Robert')
# p bob.name                  # => 'Robert'
# p bob.first_name            # => 'Robert'
# p bob.last_name             # => ''
p bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'

p bob.name = "John Adams"
p bob.first_name            # => 'John'
p bob.last_name             # => 'Adams'