# Pet Shelter
# Consider the following code:

class Pet
  attr_reader :type, :name
  def initialize(type, name)
    @type = type
    @name = name
  end
end

class Shelter
  def initialize
    @all_owners = []
  end

  def print_adoptions
    @all_owners.each do |owner|
      owner.print_list_of_pets
    end
  end

  def adopt(owner, pet)
    owner.adopt_pet=(pet)
    if !@all_owners.include?(owner)
      @all_owners << owner
    end
  end
end

class Owner
  attr_reader :name, :number_of_pets

  def initialize(name)
    @name = name
    @number_of_pets = 0
    @all_pets = []
  end

  def adopt_pet=(pet)
    @all_pets << pet
    @number_of_pets += 1
  end

  def print_list_of_pets
    puts "#{@name} has adopted the following pets:"
    @all_pets.each do |pet|
      puts "a #{pet.type} who is a #{pet.name}"
    end
    puts 
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."

# Write the classes and methods that will be necessary to make this code run, and print the following output:

# P Hanson has adopted the following pets:
# a cat named Butterscotch
# a cat named Pudding
# a bearded dragon named Darwin

# B Holmes has adopted the following pets:
# a dog named Molly
# a parakeet named Sweetie Pie
# a dog named Kennedy
# a fish named Chester

# P Hanson has 3 adopted pets.
# B Holmes has 4 adopted pets.

# The order of the output does not matter, so long as all of the information is presented.