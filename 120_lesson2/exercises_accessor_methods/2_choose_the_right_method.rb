# Add the appropriate accessor methods to the following code.

class Person
  attr_writer :name, :phone_number
  attr_reader :name
end

person1 = Person.new
person1.name = 'Jessica'
person1.phone_number = '0123456789'
puts person1.name

# Expected output:

# Jessica