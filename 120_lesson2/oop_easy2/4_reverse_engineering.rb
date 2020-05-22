# Reverse Engineering
# Write a class that will display:

# ABC
# xyz
# when the following code is run:

class Transform
  def initialize(letters)
    @letters = letters
  end

  def uppercase()
    @letters.upcase
  end

  def self.lowercase(letters)
    letters.downcase
  end
end

my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')