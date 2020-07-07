**Problem 1**
```ruby
class Wedding
  attr_reader :guests, :flowers, :songs

  def prepare(preparers)
    preparers.each do |preparer|
      case preparer
      when Chef
        preparer.prepare_food(guests)
      when Decorator
        preparer.decorate_place(flowers)
      when Musician
        preparer.prepare_performance(songs)
      end
    end
  end
end

class Chef
  def prepare_food(guests)
    # implementation
  end
end

class Decorator
  def decorate_place(flowers)
    # implementation
  end
end

class Musician
  def prepare_performance(songs)
    #implementation
  end
end

# The above code would work, but it is problematic. What is wrong with this code, and how can you fix it?
```
The code above depends too much on the dependencies hard-coded into the `Wedding#prepare` instance method. If we want to change something about the way this method is implemented, maybe adding or removing a preparer, for example, it is a lot of work. We also need to make sure that each preparer has the corresponding instance methods available in their class definitions. The logic is too complex and hard to change/debug.
However, Ruby provides a solution: duck-typing. Duck-typing is another way for Ruby to achieve polymorphism (apart from the use of inheritance and modules). It is where the class of an object is not important, but rather its ability to do a certain behavior: in this case, the availability of an instance method to that object. Each object might have a different way to implement that behavior, but the behavior is the same. 
If you want to add an object from a different class to the `#prepare` argument array, all you have to do is make sure it also has a `#prepare_wedding` method with a parameter to pass in the wedding object. Each class will have their own way to implement this method.
```ruby
class Wedding
  attr_reader :guests, :flowers, :songs

  def prepare(preparers)
    preparers.each do |preparer|
      preparer.prepare_wedding(self)
    end
  end
end

class Chef
  def prepare_wedding(wedding)
    prepare_food(wedding.guests)
  end

  def prepare_food(guests)
    # implementation
  end
end

class Decorator
  def prepare_wedding(wedding)
    decorate_place(wedding.flowers)
  end
  
  def decorate_place(flowers)
    # implementation
  end
end

class Musician
  def prepare_wedding(wedding)
    prepare_performance(wedding.songs)
  end

  def prepare_performance(songs)
    #implementation
  end
end
```


**Problem 2**
```ruby
Using the class definition from step #3, let's create a few more people -- that is, Person objects.

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')

If we're trying to determine whether the two objects contain the same name, how can we compare the two objects?
```
Because of the way equivalence works in Ruby, we understand that these two objects of the `Person` class are different objects, and even though the value contained by their respective instance variable `@name` is technically the same value, these are two different `String` objects acting as collaborator object within the state of these `Person` objects. 
Fortunately, `String#==` overrides the `BasicObject#==` in order to be able to compare values. So in order to compare the value of these two `String` objects contained in the objects' respective instance variable `@name`, we can: invoke the `Person#name` instance method on one object, which will return the `String` object with a value of `"Robert Smith"`, then because Ruby recognizes it as a String object we would call `String#==` on this and pass in the return value of `Person#name` called on the other object, which would return a boolean `true`.
The other option is to override the `BasicObject#==` within the class definition itself and invoke the getter methods exposed to us by the `attr_reader` invocation to be able to compare the `String`values referenced by the instance variable `@name` directly using the `String#==` method as described above. which will also return a boolean `true`.
```ruby
class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end
  
  def ==(other)
    name == other.name
  end
end

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')
p bob.name == rob.name # => true
p bob == rob # => true
```

**Problem 3**
```ruby
class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    "My name is #{name.upcase}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name
puts fluffy
puts fluffy.name
puts name
```
The first time you output the return value of `#name` called on the `fluffy` `Pet` object, it references and will return the same `String`  object with value `"Fluffy"` that was passed in upon object instantiated.
The problem with the way this code is written is that when you call the `#to_s` method either explicitly or by using the `puts` method invocation, it mutates the value referenced by instance variable `@name`.  For this reason, when we call the getter `#name` again after calling `puts` and passing in the object itself to it as an argument, we see the all-caps `FLUFFY` output with a return value of `nil` because the `puts` method returns `nil`. 
In order to avoid this, it is better to call a non-destructive `String#upcase` on the return value of the getter `#name` method call used by string interpolation. This way, we are using the getter method which is better practice because we might have validated or formatted the return value within this getter method, and we aren't mutating the `String` object contained within the instance variable `@name`.

**Problem 4**
```ruby
class Character
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def speak
    "#{@name} is speaking."
  end
end

class Knight < Character
  def name
    "Sir " + super
  end
end

sir_gallant = Knight.new("Gallant")
sir_gallant.name # => "Sir Gallant"
sir_gallant.speak # => "Sir Gallant is speaking."
# What change(s) do you need to make to the above code in order to get the expected output?
```
By changing the instance variable `@name` in line 9 to an invocation of the `name` getter method, we can return `"Sir Gallant"` every time the `#name` getter method is invoked, both outside of the class definition and within other instance methods of the same class (or in this case, an inherited instance method).
In lines 14-16, we override the instance method `#name` to be able to format it using the prefix `"Sir "` and calling `super` to return the return value of the `#name` getter method from the superclass. This problem demonstrates why it is generally a better idea to use getter methods calls instead of referencing the instance variable directly, because we are able to format the values for beter customization.



**Problem 5**
```ruby
module Swim
  def enable_swimming
    @can_swim = true
  end
end

class Dog
  include Swim

  def swim
    "swimming!" if @can_swim
  end
end

teddy = Dog.new
teddy.swim                                  
# How do you get this code to return “swimming”? What does this demonstrate about instance variables?
```
The currently return value of the `#swim` method called on the `teddy` object instantiated from the `Dog` class is `nil` because the instance variable `@can_swim` has not been initialized yet. This proves that, unlike local variables, uninitialized instance variables reference `nil`. In order to fix this, first we need to call `#enable_swimming` on `teddy`, and this method was provided to us by the `Swim` module mixin in line 8.
Since instance variable `@can_swim` is now referencing a boolean `true`, the `if` conditional statement on line 11 evaluates to boolean `true`and the method `#swim` now returns a `String` object with a value of `"swimming!"`

**Problem 6**
```ruby
class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end
  
  def rename(new_name)
    name = new_name
  end
end

kitty = Cat.new('Sophie')
p kitty.name # "Sophie"
kitty.rename('Chloe')
p kitty.name # "Chloe"
# What is wrong with the code above? Why? What principle about getter/setter methods does this demonstrate?
```
The problem lies in line 9, where we attempt to call the setter method `#name=` to reassign the value referenced by the instance variable `@name`. However, Ruby recognizes this as local variable assignment. To change this, we can reference the instance variable `@name` directly or we can call `#name=` on the object itself by using an explicit `self`: `self.name = new_name`

**Problem 7**
```ruby
class Team
  attr_accessor :name, :members

  def initialize(name)
    @name = name
    @members = []
  end

  def <<(person)
    members.push person
  end

  def +(other_team)
    members + other_team.members
  end
end

# we'll use the same Person class from earlier

cowboys = Team.new("Dallas Cowboys")
cowboys << Person.new("Troy Aikman", 48)

niners = Team.new("San Francisco 49ers")
niners << Person.new("Joe Montana", 59)
dream_team = cowboys + niners               # what is dream_team?
# What does the Team#+ method currently return? What is the problem with this? How could you fix this problem?
```
The `Team#+` method currently returns the return value of the `members` array with the `Array#+` method called on it and passing in the `other_team.members` array to it as an argument. It technically returns the value we expect, but the custom `Team#+` method should return a new `Team` object, following the same conventions of other `+` methods from other classes in the Ruby library that return an object of the same class. 
In the code below, I simplified it a bit to be able to work with it. I created a new `Team` object and used a setter method to add the new players to the new team's `@members` instance variable array.

```ruby
class Person; end

class Team
  attr_accessor :name, :members

  def initialize(name)
    @name = name
    @members = []
  end

  def <<(person)
    members.push person
  end

  def +(other_team)
    new_team = Team.new("Temp Team")
    new_team.members = members + other_team.members
    new_team
  end
end

# we'll use the same Person class from earlier

cowboys = Team.new("Dallas Cowboys")
cowboys << Person.new

niners = Team.new("San Francisco 49ers")
niners << Person.new
p dream_team = cowboys + niners       
```

**Problem 8**
```ruby
arr1 = [1, 2, 3]
arr2 = [1, 2, 3]
arr1.object_id == arr2.object_id      # => ??

sym1 = :something
sym2 = :something
sym1.object_id == sym2.object_id      # => ??

int1 = 5
int2 = 5
int1.object_id == int2.object_id      # => ??
# What will the code above return and why?
```
The code below returns boolean `false` because these are two different objects, even though they have the same values. When we use the `#object_id` method, we can see that they belong to two different spaces in memory.
```ruby
arr1 = [1, 2, 3]
arr2 = [1, 2, 3]
arr1.object_id == arr2.object_id      # => false
```
This will return a boolean `true`because in Ruby `Symbol` objects are used to point to the same objects. Incidentally, this is why they are so useful in hashes to make sure you are referencing the exact object you expect to reference,
```ruby
sym1 = :something
sym2 = :something
sym1.object_id == sym2.object_id      # => true
```
Similar to symbols are `Integer` objects, they also will always reference the exact same point in memory.
```ruby
int1 = 5
int2 = 5
p int1.object_id == int2.object_id      # => true
# What will the code above return and why?
```


**Problem 9**
```ruby
In the example above, why would the following not work?

def change_grade(new_grade)
  grade = new_grade
end
```
Similar to another problem previously discussed, it is necessary when using setter methods to call them with an explicit `self`, or Ruby will assume that it's local variable assignment.

**Problem 10**
```ruby
# Given the following code, modify #start_engine in Truck by appending 'Drive fast, please!' to the return value of #start_engine in Vehicle. The 'fast' in 'Drive fast, please!' should be the value of speed.

class Vehicle
  def start_engine
    'Ready to go!'
  end
end

class Truck < Vehicle
  def start_engine(speed)
  end
end

truck1 = Truck.new
puts truck1.start_engine('fast')

# Expected output:
# Ready to go! Drive fast, please!
```

In order for the `Truck` class to have access to the `Vehicle#start_engine` method's return value, we call `super` so that Ruby will traverse up the inheritance chain to look for a method of the same name. However, the `#start_engine` method in `Vehicle`  does not have an argument, so we indicate that we will not be passing in any arguments to this method by writing `super` with empty parenthesis: `super()` and then concatenating our new `String` object to output the expected value ( with a return value of `nil` because the `puts` method returns `nil`).
```ruby
class Vehicle
  def start_engine
    'Ready to go!'
  end
end

class Truck < Vehicle
  def start_engine(speed)
    super() + " Drive fast, please!"
  end
end

truck1 = Truck.new
puts truck1.start_engine('fast')

# Expected output:
# Ready to go! Drive fast, please!
```

