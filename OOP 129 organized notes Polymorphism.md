
**What is polymorphism? Explain two different ways to implement polymorphism. How does polymorphism work in relation to the public interface?**
Polymorphism literally means "many forms" - it is a way for pre-written code to be used in different and sometimes new ways by different objects in a program in response to the same method invocation. It is also a way to DRY (don't repeat yourself) up the code and reflect real-world, logical hierarchies (through inheritance) and common behaviors or functionalities (through modules). Whereas encapsulation reduces the interactivity of different parts of the program in order to protect itself, polymorphism is about expanding the abilities of the encapsulated parts of the program to interact with the different parts of itself.
Polymorphism achieves this through inheritance, `Module` mixins, and the use of duck typing.

**What is duck typing? How does it relate to polymorphism - what problem does it solve?**
Duck-typing is another way for Ruby to achieve polymorphism (apart from the use of inheritance and modules). It is where the class of an object is not important, but rather its ability to do a certain behavior: in this case, the availability of an instance method to that object. Each object might have a different way to implement that behavior, but the behavior is the same.
This is an example of polymorphism because even though there is no inheritance, you still have the ability to have two objects from different classes interact through this behavior that they have in common. For example, the classes below have no real relationship to each other except that they are both able to quack through their instance method `#quack`. When we decide to have a duck party by creating a new instance of `DuckMeeting` using the `::new` method and calling `#party` on that instance, we can pass in to the `party` method an argument array that contains an object from any class we want, as long as it has the ability to quack. Their implementations of the `#quack` method look entirely different, but the code runs as it should. The benefit of this duck-typing is that we don't have to specifiy implementation details within the `DuckMeeting#party` instance method definition, which would be a hassle to edit. Each `#quack` instance method in each particular class takes care of its own implementation details. In the example below, each class is completely independent, but still able to `#party` because they can all `#quack`. If you want to add an object from a different class to the `#party` argument array, all you have to do is make sure it also has a `#quack` method.
```ruby
class AnimalDuck
  def quack
    puts "Quack"
  end
end

class RubberDuck
  def quack
    puts "Squeak"
  end
end

class DuckMeeting
  def party(duck_invitee)
    duck_invitee.each do |duck|
      duck.quack
    end
  end
end

DuckMeeting.new.party([AnimalDuck.new, RubberDuck.new])
```

**What is inheritance? What is the difference between a superclass and a subclass? When is it good to use inheritance? Give an example of how to use class inheritance. Give an example of how to use super.**
Inheritance is a way to write reusable code in a hierarchical structure: the superclass contains basic attributes and behaviors common to all the subclasses that inherit from that superclass, and each subclass is able to be more specific in their implementation of that code. For example, in the code below, we have a `Student` class which will allow us to create objects that have a `@grade` level (an instance variable) and an ability to `#read` (an instance method).
```ruby
class Student
  def initialize(grade)
    @grade = grade
  end

  def read
    "I can read"
  end
end
```
While every `Student` instance should be able to read, we also want each student to be able to read something more specifically. A high school senior is going to read very different material than a first grade student. So we create new classes that reflect the different reading materials of each level: 
```ruby
class Student
  def initialize(grade)
    @grade = grade
  end

  def read
    "I can read"
  end
end

class ElementaryStudent
   def initialize(grade)
    @grade = grade
  end

  def read
    "I can read The BFG."
  end
end

class IntermediateStudent
  def initialize(grade)
    @grade = grade
  end

  def read
    "I can read Harry Potter."
  end
end

class HighSchoolStudent
  def initialize(grade)
    @grade = grade
  end

  def read
    "I can read Shakespeare."
  end
end

first_grader = ElementaryStudent.new(1)
sixth_grader = IntermediateStudent.new(6)
twelfth_grader = HighSchoolStudent.new(12)
```
However, this is repetitive. Every student is able to read and is a certain grade level, so we indicate inheritance by using `<`. As you can see below, we now have subclasses of the superclass `Student` that inherit the same attribute (instance variable `@grade`) and behavior (instance method `#read`) from their parent/superclass `Student`. Inheritance has allowed us to extract these common attributes and behaviors to one place, and are now available from all subclasses of `Student`. In Ruby, a subclass can only inherit from one superclass class (a superclass class can have many subclasses).
The inheritance structure below also makes use of overriding an inherited instance method and the use of the `super`method, which when invoked searches up the inheritance method lookup path to find a method with the same name, which it then returns. We can use this return value and combine it with other method calls, which extends the functionality of the subclass' instance method, and, in the case below, makes the method's return value more particular to its respective subclass: we can now see what kind of text each subclass' instance is reading by calling `#read` on the object and passing this value to `puts` as an argument (returns `nil`) to output the sentences you can see below. 
```ruby
class Student
  def initialize(grade)
    @grade = grade
  end

  def read
    "I can read"
  end
end

class ElementaryStudent < Student
  def read
    super + " The BFG."
  end
end

class IntermediateStudent < Student
  def read
    super + " Harry Potter."
  end
end

class HighSchoolStudent < Student
  def read
    super + " Shakespeare."
  end
end

first_grader = ElementaryStudent.new(1)
sixth_grader = IntermediateStudent.new(6)
twelfth_grader = HighSchoolStudent.new(12)

puts first_grader.read # => output: I can read The BFG. return: nil
puts twelfth_grader.read # => output: I can read Shakespeare. return: nil
```

**In inheritance, when would it be good to override a method?**
Inheritance is part of Ruby's polymorphism. It is the ability to define classes that inherit certain qualities or traits from another superclass. It is used to depict hierarchical structures and can help DRY up the code (keep it from getting repetitive). However, some subclasses might have different attributes or different behaviors than their parent classes or other subclasses that also inherit from the same superclass. 
Sometimes it is useful to override a method to change an object's type of attribute or behavior, perhaps to make it more specific. For example, all animals in the `Animal` class below can raise their voices, but cats and dogs have specific ways to communicate loudly. In this case, we can override the `#raise_voice` instance method to make their behaviors more specific. A fox can still communicate loudly, but since we aren't as clear about what it says, Ruby will traverse up the method lookup path to access the superclass `Animal#raise_voice` method, which the `Fox` class inherits.
```ruby
class Animal
  def raise_voice
    "I can communicate loudly"
  end
end

class Dog < Animal
  def raise_voice
    "Bark!"
  end
end

class Cat < Animal
  def raise_voice
    "Yowl!"
  end
end

class Fox < Animal; end

puts Dog.new.raise_voice # Bark!
puts Cat.new.raise_voice # Yowl!
puts Fox.new.raise_voice # I can communicate loudly
```
Sometimes it is useful to override a method when you are providing additional information. For example, in the classes defined below, the Cat and Dog classes both inherit from the Animal class. They both have access to the same instance method `Animal#swim` defined in lines 2 - 4. When the `#swim` method is invoked on the `Dog` and `Cat` instances in lines 15 and 16, Ruby will look for the `#swim` method in the instances' own class definitions first, then traverse the method lookup path to the superclass `Animal`. A dog and a cat are both able to swim, but in the cat's case, we are adding additional information about its ability to swim by using the `super` keyword which accesses the superclass' return value of the `Animal#swim` instance method, then using string concatenation to supply additional information about a `Cat` object's behavior.
```ruby
class Animal
  def swim
    "I can swim"
  end
end

class Dog < Animal; end

class Cat < Animal
  def swim
    super + ", but I really don't like it"
  end
end

Dog.new.swim # output: I can swim
Cat.new.swim # output: I can swim, but I really don't like it
```


**What is a module? What is a mixin?**
A module is a way for Ruby to share common behaviors across unrelated classes. It is Ruby's answer to multiple inheritance. A module is defined similarly to a class definition: the reserved word `module`, the name of the module in CamelCase (since modules contain methods and methods are behaviors, typically the name is a verb with an 'able' suffix), and a keyword `end`.
A module can also group together common classes and behaviors, which is called namespacing. 
In the code below, we can see a superclass called `Person` that has two branches of inheritance: `Adult`(inherits from `Person`which has a subclass `WorkingAdult` (inherits from `Adult`), and `Student` which inherits from `Person`. For this example, let's pretend that only `Student`objects and `WorkingAdult` objects can take a bus. We don't want to give all people the ability to take the bus, but we don't want to define a `#take_bus` instance method twice and be repetitive. 
A way to extract this logic and use in throughout the program in unrelated classes is to define a module, which is defined using the `module` reserved word and the name of the module written in CamelCase (along with the `end` reserved word to denote the end of the module definition. This module is then included in each class definition by using the `include`method invocation, followed by the name of the module. This process is called a mixin. The instance methods defined in this module are now available to the class through this mixin process.
```ruby
module Transportable
  def take_bus
    "I get on a bus every morning."
  end
end

class Person; end

class Adult < Person; end

class WorkingAdult < Adult
  include Transportable
end

class Student < Person
  include Transportable
end

puts Student.new.take_bus # => output: I get on a bus every morning. return: nil
puts WorkingAdult.new.take_bus # => output: I get on a bus every morning. return: nil
```

**super**
```ruby
class Student
  def learn
    "Learning"
  end
end

class HighSchoolStudent < Student
  def learn
    super + " how to read Shakespeare"
  end
end
  
student = HighSchoolStudent.new
puts student.learn # => output: Learning how to read Shakespeare, returns: nil
```
There are several ways to use `super` in a method definition: when looking for return values of instance or class methods, or when looking for values of instance variables. The `super` method is used in inheritance to DRY (don't repeat yourself) up the code. 
When you call the `super` method within an instance or class method, it traverses up the inheritance method lookup path for the instance or class method of the same name (and scoped at the same level) and returns the return value of that method. You really only need it when you are going to add more particular details to that return value or use that value to behave in a different way, because otherwise the method and its return value are already inherited from the superclass when you use the `<` symbol as you can see in line 7 above, so the use of `super` without anything extra added to its functionality would just be redundant. In the example above, when we create a new `HighSchoolStudent` object (referenced by the `student` local variable in line 13) that inherits from the `Student` class, we want to be a little more specific about what the student can learn, so we define an instance method called `#learn` that overrides the `#learn` instance method defined in the `Student` class. However, we still want to access the return value of the superclass' `#learn` instance method, so we invoke `super`, which traverses up the method lookup path looking for its superclass' instance method of the same name and returns the return value of `Student#learn`: a String object with a value of `"Learning"`. Using string concatenation, we add more details to what the `student` object is learning in the `HighSchoolStudent#learn` instance method definition, so when we call `puts` and pass in the return value of this method call on the `student` object in line 14, we see the output `Learning how to read Shakespeare` (returns `nil` because `puts` returns `nil`).

Another way of using the `super` method invocation is when referring to inherited instance variables. For example, the `HighSchoolStudent` class below inherits from `Student`, but since high schoolers also have a GPA, we have an additional attribute passed in to our constructor method when we instantiate the `student` object by calling `::new` on the `HighSchoolStudent` class and passing in two values to the `#initialize` method as an argument. 
```ruby
class Student
  attr_reader :grade
  def initialize(grade)
    @grade = grade
  end
end

class HighSchoolStudent < Student
  def initialize(grade, gpa)
    super(grade)
    @gpa = gpa
  end
end
  
student = HighSchoolStudent.new(11, 3.5)
p student.grade # => 11
```
`Student` already has an instance variable that references the `@grade` of the student, so we don't need to repeat that in our `HighSchoolStudent` class definition's constructor method (`#initialize`). In order to not repeat it, we can call the `super` method inside of the constructor method definition and pass in the value referenced by local variable `grade` to it as an argument. The `super` method will look for the `#initialize` instance method in the superclass and pass the `grade` to it as an argument, thereby initializing the instance variable `@grade` to now reference the integer object with value of `11` that was passed in to the `::new` method on line 15 as an argument. This is why I am able to get a return value that is not `nil` when I call `#grade` on the `student` object (also because the getter method created through `attr_reader :grade` exposes this method which returns the value referenced by the `@grade` instance variable).
If the method you are referring to with `super` has an argument, the invokation of `super`  must also contain an argument.
Here is a different problem: my `Student#learn` instance method does not have a parameter, but the `HighSchoolStudent#learn` instance method does. When I invoke `#learn` on the `student` object, I pass in a String object to it as an argument. If I try to invoke `super`, it will look for an instance method in the `Student` superclass that also has an argument so it can pass in the argument stored in the local variable `topic`. It won't find a `#learn` instance method with an argument in the superclass, so it will raise an `ArgumentError: wrong number of arguments`. We can indicate to `super` that no arguments will be passed by `super` by adding empty parentheses: `super()` - no arguments will be passed.
```ruby
class Student
  def learn
    "Learning "
  end
end

class HighSchoolStudent < Student
  def learn(topic)
    super() + topic
  end
end
  
student = HighSchoolStudent.new
p student.learn("Shakespeare")
```

**What is the method lookup path? How do you find the lookup path for a class? (lookup path stops when you find it) How is the method lookup path affected by module mixins and class inheritance?**

The method lookup path is where Ruby looks for an invoked method's definition. When a method is called on an object, Ruby first looks in the object's class definition, then if doesn't find it there, it traverses up the method lookup path until it finds the method. Otherwise, it returns a NoMethodError. In order to find the method, it must be in scope.
You can see the method lookup path by calling `::ancestors` on the class. It will return an array of the classes in the order in which Ruby looks for a method.
```ruby
class Student; end

p Student.ancestors # => [Student, Object, Kernel, BasicObject]
```
When taking into consideration inheritance and the use of modules, the method lookup path will always look in the class first, then any modules that have been mixed in, then superclasses.
In the example below, we can see that our `HighSchoolStudent` class has two module mixins and a superclass. The method lookup path will first look in the `HighSchoolStudent` class definition, then will look at the module definitions in reverse order in which they are written: `Learnable` first, then `Studyable`. Finally, Ruby traverses up to the superclass `Student` and onward up the inheritance chain until we arrive at the class definition for the parent of all classes in Ruby, `BasicObject`.
```ruby
module Studyable; end

module Learnable; end

class Student; end

class HighSchoolStudent < Student
  include Studyable
  include Learnable
end

p HighSchoolStudent.ancestors # => [HighSchoolStudent, Learnable, Studyable, Student, Object, Kernel, BasicObject]
```

**What is the default to_s method that comes with Ruby, and how do you override this? What are some important attributes of the to_s method? Why is it generally a bad idea to override methods from the Object class, and which method is commonly overridden?**
The default `to_s` method that comes with Ruby is from the `Object` class and is what is displayed when we are printing the object itself. It is used when we use `self` to refer to the object in string interpolation within an instance method or when we call `puts` on an object. As it is defined in the `Object` class, it will return a `String` object with the name of the class and an encoding of the object id,
```ruby
class Student
  def initialize(name)
    @name = name
  end
end

student = Student.new("Megan")
puts student # => output: #<Student:0x000055ec01e8be38>  (returns nil)
```
You can override this within a class definition to format the way you want to display your custom object. You override the `#to_s` method by defining it like you would any other instance method. 
```ruby
class Student
  def initialize(name)
    @name = name
  end
  
  def to_s
    "student #{@name}"
  end
  
  def display_name
    "#{self}"
  end
end

student = Student.new("Megan")
puts student # => output: student Megan  (returns nil)
p student.display_name # => "student Megan"
```
In the example above, we can see that using `self` within string interpolation within an object will now return "student Megan" because string interpolation automatically calls `to_s` on the object or method return value that is being passed in.

It is generally a bad idea to override a method from the `Object` class because these are commonly used methods and you could forget that you have overridden the method and get an unexpected return value in the program. The `Object` methods are also useful for debugging, so you would be taking away your ability to debug properly.

**What happens when you call the p method on an object? And the puts method? How do you override the to_s method? What does the to_s method have to do with puts?
What is the default return value of to_s when invoked on an object? Where could you go to find out if you want to be sure?**
`p` is synonymous with calling `inspect`, and if you just call `p` on an object, it will return a string representation of the object: its class name, an encoding of the object id, and any instance variables and their respective values that are part of its state.
The `puts` method displays the object with `to_s` called on it. If you want to override the `to_s` method, you can define it in the class definition as an instance method `to_s`. 

