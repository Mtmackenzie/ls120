**What is encapsulation? How does encapsulation relate to the public interface of a class?**
Encapsulation is part of OOP's response to the complexity of programs that hides parts of the program from other parts of the program to protect data. It is a way to reduce dependencies between different parts of the program so that changes (either intentional or not) to one part of the program do not affect or break the entire program. It is easier to debug, and it allows for better control over the public interface of the program and what the user or different parts of the program are able to do or access.
Encapsulation mainly happens in Ruby through the use of objects. When an object is instantiated from a class, its scope is particular to the instance level and it is able to behave in certain ways through the use of instance methods defined in the class definition. The object can also keep track data or particular attributes about itself, which it stores in instance variables. These behaviors or attributes can be made available to the user through the program's interface through methods that are public, private (only available to the object itself), or protected (available to be used by other objects of the same class). In this way, data is protected from accidental changes and the program is easier to manage despite its complexity because the different parts of the program are compartmentalized and not completely dependent on each other. This allows for new levels of abstraction and the ability to represent real-life objects and behaviors.
The public interface of a class is what the user or other parts of the program are able to access, use, or change, depending on if the method is intentionally exposed to the public interface or not. This allows for better control of what the user or program knows about or is able to do with an object.
```ruby
class Person
  def initialize(name)
    @name = name
  end
end

person = Person.new("Megan")
```
In the example above, we instantiate a new object from the `Person` class and passed in a String object with a value of `"Megan"` to it as an argument (we can reference this new object through the local variable `person`). Within the class definition (defined using the keyword `class` and the name of the class in CamelCase, with a keyword `end` to denote the end of the class definition), the constructor method `#initialize` defined with the parameter `name`allows us to save `"Megan"` inside the object as an attribute stored in the `@name` instance variable.  It is a part of the `person` object's state. As the code is written now, there are no methods exposed that will allow us to access the person's name or change it. This bit of data is encapsulated within the state of the object.

**What is a class? What is an object? How do you initialize a new object? What is instantiation?**
A class is a mold that serves as a blueprint for objects (a class is itself an object). It can be defined by using the keyword `class`, the name of the class in CamelCase, and the keyword `end`. 
```ruby
class Person
end
```
The class allows instances or objects instantiated from that class to be a certain way (to hold information about itself via instance variables) or to do certain behaviors (via instance methods). In the code below, a `person` object is instantiated from the `Person` class by calling `::new` on the `Person` class. The `::new` method triggers the `#initialize` method. `#initialize` is also known as a constructor method because it constructs the state of the object. In the code below, we can see that the `@name` instance variable is set equal the value of the local variable `name` used as a parameter in order to pass this value in to `#initialize` when the String object with a value of `"Megan"` is passed in to `::new` as an argument.
```ruby
class Person
  def initialize(name)
    @name = name
  end
end

person = Person.new("Megan")
```
The local variable `person` is now referencing this new object. In the code below, the `Person` class contains the mold for a person who has a name and has the behavior `#study`, which is an instance method defined within the class definition and available to instances of that class. For this reason, when we call `#study` on the local variable `person`, we are actually calling `study` on the `Person` object instantiated in line 11, now referenced by the local variable `person`. The return value of this method call is a String object with a value of `"Studying!"`.
```ruby
class Person
  def initialize(name)
    @name = name
  end
  
  def study
    "Studying!"
  end
end

person = Person.new("Megan")
person.study # => "Studying!"
```
To summarize, classes are molds that determine the attributes and behaviors of objects/instances of that class. The object contains unique data particular to itself, but the data and the behaviors of that object are predilected by the class definition.


**When defining a class, we usually focus on state and behaviors. What is the difference between these two concepts?**
The state of an object is the sum of its unique attributes. Its attributes are contained in the data found in the instance variables. A behavior of an object is what the object is able to do based on the instance methods provided by the class definition for all instances of that class.
```ruby
class Person
  def initialize(name)
    @name = name
  end
  
  def study
    "Studying!"
  end
end

person1 = Person.new("Megan")
person2 = Person.new("Meg")
person1.study
person2.study
```
For example, `person1` and `person2` are both objects instantiated from the `Person` class. `person1` has a different name than `person2`, but both objects are able to have names (stored in the instance variable `@name`, and both objects are also able to study (a behavior exposed through the instance method `Person#study`. Also, even if the `@name` instance variables of `person1` and `person2` were to both reference same string value, you could not say that they have the same state; they are still different objects that are stored in different places in memory, which is also part of the object's state, as reflected below when you call `#object_id` on these objects:
```ruby
class Person
  def initialize(name)
    @name = name
  end
  
  def study
    "Studying!"
  end
end

person1 = Person.new("Megan")
person2 = Person.new("Megan")
p person1.object_id # => 46936566022640
p person2.object_id # => 46936566039760, different from above
```

**How do you see if an object has instance variables?**


**Using getters and setters**
The getter and setter methods are used by Ruby in the class definition to allow the instance method definitions or the user in the public interface to access or change the values saved in the instance variables of each instance of that class.
For example, Animal class below contains two instance method definitions. In line 12, the setter method `Animal#name=(value)` is invoked on the `cat` object initialized in line 11. This instance method is defined on lines 7-9 to set the `@name` instance variable to reference a string object with a value of `"Vaquita"`. Another way of writing this would be `cat.name=(name)`, but Ruby's syntactical sugar allows us to call the method like this: `cat.name = name`.
When the `Animal#name` getter method is invoked on line 14, the return value is the value referenced by the instance variable `@name` on line 4. If we had not set the `@name` instance variable to point to the String object with a value of `"Vaquita"`, the uninitialized instance variable `@name` would be set to `nil`, which is a particular quality of instance variables as opposed to local variables that would raise an error.
```ruby
class Animal
  
  def name
    @name
  end
  
  def name=(name)
    @name = name
  end
end

cat = Animal.new
cat.name =  "Vaquita"
puts cat.name  # Vaquita
```
Because these getter and setter methods are so common, Ruby provides a further way to simplify the code through the following syntactical sugar:
```ruby
class Animal
  attr_accessor :name
end

cat = Animal.new
cat.name =  "Vaquita"
puts cat.name  # Vaquita
```
 The `attr_accessor` method is shorthand for the getter and setter methods explained above. This method, in turn, is shorthand for the following methods: `attr_reader`, which is the getter method, and `attr_writer`, which is the setter method.

**Use attr_* to create setter and getter methods**
One way that Ruby provides encapsulation is through the use of getter and setter methods to expose the data referenced by the instance variables. As you can see in the code below, the `student` object is instantiated by calling the `::new` method on the `Student` class and passing in an Integer object with a value of `10` to it as an argument. `::new` triggers the `#initialize` instance method with parameter `grade`. An instance variable `@grade` is initialized and is now pointing at the same integer object that local variable `grade` is pointing at. 
This piece of data is an attribute of the `student` object, now part of the state of the object (its state is the sum of its attributes, stored in instance variables). However, we can't access this piece of information. It is encapsulated within the state of the object and is not available to the public interface.
```ruby
class Student
  def initialize(grade)
    @grade = grade
  end
end

student = Student.new(10)
student.grade # => NoMethodError: undefined method `grade' for #<Student:0x000055e045ef99c8 @grade=10>
```
One way to fix this is to create getter and setter methods, but Ruby provides a simpler way to access the data stored in these instance variables: `attr*_` methods. All `attr*_` methods take a `Symbol` as an argument, and they can take multiple symbols separated by commas if there are multiple instance variables we want to expose. We can get the data referenced in the `@grade` instance variable by calling `attr_reader` in our class definition outside of any instance methods because this method is Ruby syntactical sugar to replace an instance method; it has the same scope as an instance method and can be called on the object itself. In the code snippet below, we have added the `attr_reader` method and passed in the symbol `:grade` to it as an argument. This allows us to call `#grade` on the object and see the value that is referenced by the instance variable `@grade`.
```ruby
class Student
  attr_reader :grade
 
  def initialize(grade)
    @grade = grade
  end
end

student = Student.new(10)
p student.grade # => 10
```
Let's say we want to reassign the instance variable `@grade` to a new grade to reflect the fact that the student is now in 11th grade. We could create a setter method, or we could use the `attr_writer` method and pass in the symbol `:grade` to it as an argument. This allows us to change the value referenced by the instance variable `@grade`. Outside of the class definition, we can call `student.grade = 11` with the new `Integer` object with a value of `11` passed to `#grade` as an argument. This is shorthand for `student.grade=(11)
```ruby
class Student
  attr_reader :grade
  attr_writer :grade

  def initialize(grade)
    @grade = grade
  end
end

student = Student.new(10)
student.grade = 11 # this is the same as writing student.grade=(11)
p student.grade # => 11
```
In the code above, Ruby provides yet another way to express this through syntactical sugar: since we are using both getter and setter methods, we can call `attr_accessor` and combine these two functionalities into this one simple line of code.
```ruby
class Student
  attr_accessor :grade

  def initialize(grade)
    @grade = grade
  end
end

student = Student.new(10)
student.grade = 11 # this is the same as writing student.grade=(11)
p student.grade # => 11
```
And finally, what if we want to retain some control over the ability to get or set this information? For example, let's say the student has another attribute, referenced by instance variable `@gpa`. We want to be able to get and set the student's grade, but we only want to be able to see their GPA, not change it. In this case, we can call `attr_accessor :grade`, and `attr_reader :gpa` at the top of our class definition, thus encapusating this data from being changed from outside the program.
```ruby
class Student
  attr_accessor :grade
  attr_reader :gpa

  def initialize(grade, gpa)
    @grade = grade
    @gpa = gpa
  end
end

student = Student.new(10, 3.5)
p student.gpa # => 3.5
student.gpa = 4.0 # => NoMethodError: undefined method `gpa=' for #<Student:0x0000557df8b80d28 @grade=10, @gpa=3.5>
```


**Public, private, protected methods**
We have a `Student` class definition from which we can instantiate an object that has attributes `@grade` and `@gpa` stored in instance variables within the state of the object. We have called the `attr_reader` method and passed in the symbols `:grade` and `:gpa` to it as an argument, which means we now have access to the getter methods that will expose the values referenced by these instance variables.  We also have access to these getter methods inside of our other instance method definition called `Student#print_transcript`.
```ruby
class Student
  attr_reader :grade, :gpa

  def initialize(grade, gpa)
    @grade = grade
    @gpa = gpa
  end
  
  def print_transcript
    puts "Grade: #{grade}. GPA: #{gpa}."
  end
end

student = Student.new(10, 3.5)
p student.gpa # => 3.5
```
However, let's say for privacy reasons, we only want these getter methods to be accessible from within the `#print_transcript` instance method. All instance methods are by default public, but we can call `private` in the class definition and anything below that method invocation will become unavailable to the public interface, as we can see in line 18 below: when we try to call `#gpa` on the `student` object, a `NoMethodError` is raised.
However, these private getter methods are still available to be invoked within other instance method definitions. In the code below, we can see that in the `Student#print_transcript` method, the `#grade` and `#gpa` private methods are invoked and their return values are used in string interpolation. (As you can see in line 17, the output is "Grade: 10. GPA: 3.5." and the return value is `nil` because of the `puts` method, which passed in this string interpolation to it as an argument.)
```ruby
class Student
  def initialize(grade, gpa)
    @grade = grade
    @gpa = gpa
  end
  
  def print_transcript
    puts "Grade: #{grade}. GPA: #{gpa}."
  end
  
  private
  
  attr_reader :grade, :gpa
end

student = Student.new(10, 3.5)
student.print_transcript # => output: Grade: 10. GPA: 3.5. returns: nil
student.gpa # => NoMethodError: private method `gpa' called for #<Student:0x00005654c06faea8 @grade=10, @gpa=3.5>
```
And finally, let's say we want to be able to get some values from one object and compare them to another object within an instance method. The `protected` method invocation allows us to access instance methods of other objects from that same class. `protected` methods are accessible from inside the class just like public methods, but outside the class `protected` methods act like `private` methods and are unavailable.
In the example below, we have two different class definitions: `Student` and `Teacher`. Both classes have an instance variable called `@gpa` and both classes have an `attr_reader` getter method invocation with `:gpa` passed in as an argument. If we were to call `#gpa` on either a `Student` or a `Teacher` object, we would get a `NoMethodError: protected method gpa called` because `protected` methods act like private methods when called outside of the class definition.
For our example below, we have instantiated two different `Student` objects and one `Teacher` object. When we call `#compare_gpa` on our `student` object and pass in `student2` object to it as an argument, within the class definition and within the `#compare_gpa` instance method, `student2` is passed in as an argument. `#gpa` in line 7 is called with an implicit caller, meaning it is calling the getter instance method `#gpa` without needing to use the explicit caller `self` because it understands that it is referring to itself. The return value of this method call has a method called on it: the `#>` method, with an argument passed in consisting of the return value of `#gpa` called on the object passed in as an argument. This returns a boolean `true` or a boolean `false`, which we can see in line 28. This is possible even though the `#gpa` getter method is protected because both objects are instances of the same class, proving that `protected` methods are available to other objects of the same class within the class definition.
However, when we try to compare a `Student` object with a `Teacher` object, we see that there is a `NoMethodError: protected method gpa called for #<Teacher:`. Because the `teacher` object has a `protected` getter method, it is not accessible outside of its own class definition, proving second fact about `protected` methods that outside of their class definition they act like `private` methods.
```ruby
class Student
  def initialize(gpa)
    @gpa = gpa
  end

  def compare_gpa(other)
    gpa > other.gpa
  end

  protected
  
  attr_reader :gpa
end

class Teacher
  def initialize(gpa)
    @gpa = gpa
  end
  
  protected
  
  attr_reader :gpa
end

student = Student.new(3.5)
student2 = Student.new(1.0)
teacher = Teacher.new(4.0)
p student.compare_gpa(student2) # => true
p student.compare_gpa(teacher) # => NoMethodError
```


It's possible to use a combination of protected and private instance methods:

```ruby
class Student
  def initialize(grade, gpa)
    @grade = grade
    @gpa = gpa
  end
  
  def compare_class_rank(other)
    if grade == other.grade
      gpa > other.gpa ? "higher ranked" : "lower ranked"
    else
      "Not in the same class!"
    end
  end
  
  protected

  attr_reader :grade, :gpa
  
  private
  
  attr_writer :grade, :gpa
end

student = Student.new(10, 3.5)
student2 = Student.new(10, 3.0)
student3 = Student.new(11, 4.0)
p student.compare_class_rank(student2) # => "higher ranked"
p student2.compare_class_rank(student3) # => "Not in the same class!"
```
When calling a protected or private setter method inside a public instance method, it is important to use an explicit `self` caller. `self` refers to the object itself, and then you can call the protected or private instance method on this explicit `self` caller. This is necessary because otherwise Ruby does not identify the setter method as a setter method but rather a local variable assignment.
In the code below, our `Student` class is defined with one instance variable `@gpa` and has an `attr_reader` getter method. It also has a `attr_writer` setter method, but this method is defined below the `private` method invokation, meaning it is only available to be used in other instance method definitions. 
The instance method `change_gpa` takes an argument and calls the private setter method in order to change the value of `@gpa`. As you can see, we have to call the setter using an explicit `self`. When we call `#gpa` using the getter method on our `student` object, we can see that the GPA has been changed from a `Float` object with a value of `3.5` to a `Float` object with a value of `2.5`.
```ruby
class Student
  attr_reader :gpa

  def initialize(gpa)
    @gpa = gpa
  end
  
  def change_gpa(new_gpa)
    self.gpa = new_gpa
  end

  private
  
  attr_writer :gpa
end

student = Student.new(3.5)
p student.change_gpa(2.5)
p student.gpa # => 2.5
```
**Why is it generally safer to use an explicit self. caller when you have a setter method unless you have a good reason to use the instance variable directly?**
When deciding whether to use a setter method or to reassign the value of the instance variable directly, they are both options but it is generally better to use the setter method unless you have a good reason to use the instance variable directly. The setter method can allow you to validate ro format the new value that you are assigning to the instance variable, and thus prevent and bugs later on in the program. For example, the code below changes the value of the instance variable `@gpa` directly, but I can change it to a `String` object which could cause problems later on if I'm expecting a `Float` object.
```ruby
class Student
  attr_reader :gpa
  
  def initialize(gpa)
    @gpa = gpa
  end

  def change_gpa(new_value)
    @gpa = new_value
  end
end

student = Student.new(3.5)
student.change_gpa("4")
p student.gpa # => "4"
```
To avoid this, I can create a setter method `#gpa=` and format the `new_value` argument to always assign the `@gpa` instance variable to reference a `Float` object. 

**What are class methods?**
A class method is defined by using the prefix `self.` and then the name of the method, and is called directly on the class itself: `Class.method`. For example, the `Student` class below contains one method definition. You can tell it is a class method because it has the word `self` prepended.  In line 7, when I call the method, I call it directly on the class itself: `Student.name`. This returns a `String` object with a value of `"I am the Student class"`. The `self` inside of the `::name` definition refers to the class itself, because class methods are scoped at the class level.
```ruby
class Student
  def self.name
    "I am the #{self} class"
  end
end

p Student.name # => "I am the Student class"
```
