**What is the purpose of a class variable? What are the scoping rules for class variables? What are the two main behaviors of class variables?
Are class variables accessible to sub-classes? Why is it recommended to avoid the use of class variables when working with inheritance? 
**
A class variable contains information related to the entire class, and is created using `@@` then the name of the class variable: `@@example_class_variable`. Every object shares a copy of that class variable. The class variable can be initialized anywhere within the class definition, and it is available to the class and to all of its instances, outside of and within both class and instance method definitions.
In the example below, we have defined `Student` class that contains a class variable `@@total_number_of_students`, initialized in line 2 and referencing an `Integer` object with a value of `0`. When we call the class method `::total_count` on the `Student` class itself, it will return this same value `0`. 
We then instantiate a new object from the `Student` class. Within the `#initialize` constructor method, the class variable is reassigned to the return value of the object it is currently referencing with the `Integer#+` method called it and `Integer` with a value of `1` passed in as an argument (this is Ruby's syntactical sugar for reassignment). Every time a new instance is instantiated, this reassignment will happen.
In line 19, we again call the class method `::total_count` on the `Student` class and can see that the value has changed.
In line 20, we can see that the class variable is also accessible within the scope of the instance method `#total_count` (as it was also accessible withinin the scope of the constructor instance method).
```ruby
class Student
  @@total_number_of_students = 0
  
  def initialize
    @@total_number_of_students += 1
  end
  
  def self.total_count
    @@total_number_of_students
  end
  
  def total_count
    @@total_number_of_students
  end
end

p Student.total_count # => 0
student1 = Student.new
p Student.total_count # => 1
p student1.total_count # => 1
```
Class variables used in a subclass are inherited along with all of the other attributes and behaviors of the superclass, and thus are scoped and able to be changed within both instance and class methods of a subclass.
In the code below, we have created a new subclass `ElementaryStudent` that inherits from `Student`. When we instantiate an `ElementaryStudent` object, we are able to change the value of the `@@total_number_of_students` class variable, and we have been able to expose the value referenced by this class variable in the classes and instances of both the superclass `Student` and the subclass `ElementaryStudent`.
```ruby
class Student
  @@total_number_of_students = 0
  
  def initialize
    @@total_number_of_students += 1
  end
  
  def self.total_count
    @@total_number_of_students
  end
  
  def total_count
    @@total_number_of_students
  end
end

class ElementaryStudent < Student; end

p Student.total_count # => 0
student1 = Student.new
p Student.total_count # => 1
p student1.total_count # => 1

third_grader = ElementaryStudent.new
p Student.total_count # => 2
p student1.total_count # => 2
p ElementaryStudent.total_count # => 2
p third_grader.total_count # => 2
```
However, there is a potential problem: because all classes and objects share a copy of the class variable, if we hard-code change the value of the class variable in a subclass, it will change the value across all classes and in both the class and instance scopes of the inheritance chain. This is true for just reassignment outside of instance method definitions:
```ruby
class Student
  @@total_number_of_students = 0
  
  def initialize
    @@total_number_of_students += 1
  end
  
  def self.total_count
    @@total_number_of_students
  end
  
  def total_count
    @@total_number_of_students
  end
end

class ElementaryStudent < Student
  @@total_number_of_students = 45
end

p Student.total_count # => 45
student1 = Student.new
p Student.total_count # => 46
p student1.total_count # => 46

third_grader = ElementaryStudent.new
p Student.total_count # => 47
p student1.total_count # => 47
p ElementaryStudent.total_count # => 47
p third_grader.total_count # => 47
```
If the class variable is reassigned within the scope of an instance method, there will be no change unless we call the method. All classes and objects in the same inheritance chain will then reference this new value.
```ruby
class Student
  @@total_number_of_students = 0
  
  def initialize
    @@total_number_of_students += 1
  end
  
  def self.total_count
    @@total_number_of_students
  end
  
  def total_count
    @@total_number_of_students
  end
end

class ElementaryStudent < Student
  def some_method
    @@total_number_of_students = 45
  end
end

p Student.total_count # => 0
student1 = Student.new
p Student.total_count # => 1
p student1.total_count # => 1

third_grader = ElementaryStudent.new
p Student.total_count # => 2
p student1.total_count # => 2
p ElementaryStudent.total_count # => 2
p third_grader.total_count # => 2
third_grader.some_method
p Student.total_count # => 45
```
Another quality of class variables is that they can be changed even from within an uninstantiated class. Since the value is loaded when the classes are evaluated by Ruby, it will begin with the last assigned value.
```ruby
class Student
  @@total_number_of_students = 0
  
  def initialize
    @@total_number_of_students += 1
  end
  
  def self.total_count
    @@total_number_of_students
  end
  
  def total_count
    @@total_number_of_students
  end
end

class ElementaryStudent < Student
  @@total_number_of_students = 45
end

class HighSchoolStudent < Student
  @@total_number_of_students = 1000
end

p Student.total_count # => 1000
student1 = Student.new
p Student.total_count # => 1001
p student1.total_count # => 1001

third_grader = ElementaryStudent.new
p Student.total_count # => 1002
p student1.total_count # => 1002
p ElementaryStudent.total_count # => 1002
p third_grader.total_count # => 1002
```
For these reasons, it is unadvisable to use class variables when working with inheritance, because a reassignment somewhere down the inheritance chain will affect the value of the copy of this class variable shared throughout all super- and subclasses.

** What is a constant variable? Is it possible to reference a constant defined in a different class? How are constants used in inheritance? What is lexical scope? When dealing with code that has modules and inheritance, where does constant resolution look first? What are the scoping rules for constant variables?**


A constant variable is a variable with lexical scope that is written using all capital letters and is a value that should not change will running the program. It is useful to contain values that you could easily edit in one place later instead of hard-coding into the logic of the program - it's a way of extracting this value from the logic for an easy way to change the value later if needed.
Constants are inherited by subclasses and can be overridden. Constants initialized in a subclass are not accessible in a superclass; however, it is possible to override a constant initialized in a superclass by assigning it in a subclass.
When dealing with code that has modules and inheritance, Ruby will look in the class or module in which it is called to try to find its value, unless otherwise indicated. It is important to identify where the constant is located by referring to its class name, using a namespace resolution operator, and then referring to the constant. Otherwise because of the lexical scope of constants, Ruby won't know where to look.
In the example below, the `Student` class inherits from the `Person` class, which has a `Studyable` mixin. The way the `Studyable#study` instance method is written now, Ruby will only look for the constant `NUM_OF_BOOKS` in the module `Studyable` because of the constant's lexical scope, and it won't find it, so it will raise an error.
```ruby
module Studyable
  def study
    "Studying #{NUM_OF_BOOKS} books"
  end
end

class Person
  include Studyable
  NUM_OF_BOOKS = 2
end

class Student < Person
end

student = Student.new
p student.study # => NameError: uninitialized constant Studyable::NUM_OF_BOOKS
```
In order to fix this, we must refer to the constant using the class name in which is was initialized, the namespace resolution operator, and the name of the constant. 
```ruby
module Studyable
  def study
    "Studying #{Person::NUM_OF_BOOKS} books"
  end
end

class Person
  include Studyable
  NUM_OF_BOOKS = 2
end

class Student < Person
end

student = Student.new
p student.study # => "Studying 2 books"
```
Since the `Student` class inherits from the `Person` class, the constant is also available to the `Student` class, so we can also tell Ruby to refer to the constant as part of the `Student` class:
```ruby
module Studyable
  def study
    "Studying #{Student::NUM_OF_BOOKS} books"
  end
end

class Person
  include Studyable
  NUM_OF_BOOKS = 2
end

class Student < Person
end

student = Student.new
p student.study # => "Studying 2 books"
```


**How do you determine if two variables actually point to the same object? What is the equal? method?**
The `equal?` method is a `BasicObject` method that can show us if two variables are pointing to the same object (returns a boolean `true` or a boolean `false`). It is especially useful when comparing objects of classes that have overridden their `#==` method to only look at values. The `equal?` method will actually check to see if the object is pointing at the same space in memory, like if we were to compare calling `#object_id` on both objects.
```ruby
a = "hello"
b = "hello"

p a == b # => true
p a.equal?(b) # => false because these are actually two different String objects, even though they have the same value
p a.object_id == b.object_id # => false
```

**Is it possible to compare two objects of different classes?**
Yes, as long as you have defined a `#==` or `#<=>` method that specifies which value to evaluate. Otherwise, you'll just be comparing objects themselves.
```ruby
class Person
  attr_reader :age

  def initialize(age)
    @age = age
  end
end

class Student
  attr_reader :age

  def initialize(age)
    @age = age
  end
  
  def <(other)
    age < other.age
  end
end

p Student.new(20) < Person.new(21) # => true
```
**What is the === method?**
The `#===` method is used implicitly in case statements to determine if an object is part of a group.
```ruby
case 15
  when 10..20 # The Range#=== method is used implicitly here to check if the Integer object 15 is part of this Range object 10..20
  puts true
end
```

**What is the eql? method?**
The `#eql?` method checks to see if the objects are from the same class and have the same value. It is primarly used when comparing hashes.

**Explain the idea of fake operators and give an example.**
In Ruby, most operators are actually methods that look like operators because Ruby provides syntactical sugar in order for us to write and read them more naturally. In fact, only a few operators are true operators: logical "and" `&&`, logical "or" `||`, and `=` used in assignment are some examples. 
Some examples of common fake operators that are actually methods are `==` the equality method, `<`, `>`, and even `[]`. These are all methods, which means we can override them in our class definitions for customization based on the objects, and perhaps even their particular values, that we want to work with. It is a good idea to follow the same logic that other classes in the standard Ruby library use when overriding (especially taking into consideration return values and outputs), to avoid confusion.

see example below, which works for both questions
**How does equivalence work in Ruby? What is `==` in Ruby? How does `==` know what value to use for comparison? What do you get “for free” when you define a == method?**

Equivalence in Ruby is possible because each class implements the `#==` method a little differently, but the idea is the same: to compare the object's value. We aren't necessarily seeing if it's the same object, rather if the object has the same values. The `String` class has defined its own version of  `#==`, the `Array` class its own version, etc. When we are defining our own classes with custom values and we want to compare them, we need to decide what we want to compare about the object. For example, if we have two different `Student` objects that have several different attributes stored as part of their states, we need to decide which of those attributes we want to be compared. Even if these objects contain the same values, when we use the `#==` method as it is provided by the `BasicObject` class, we are comparing the objects in their entirety to each other, which will never return boolean `true` if they are two different objects because they will always occupy two different places in memory.
```ruby
class Student; end

student1 = Student.new
student2 = Student.new

p student1 == student2 # => false
```


For example, the `==` equality method normally checks to see if an object is equal to another object (to see if it is the same object). However, with custom objects, we can override this method in our class definition to make it compare values of particular attributes of the object stored in the object's instance variables instead of the object itself.
In the `Student` class definition below, we can see that the instances of the `Student` class contain a `Float` value that is referenced by the `@gpa` instance variable. We want to be able to compare these values directly instead of comparing the object itelf, so we override the `#==` equality instance method by definition it with a parameter `other`.
When we call `student1 == student2`, this is actually syntactical sugar for `student1.==(student2)` which means we are passing in the object `student2` to the `#==` method as an argument. Within the `#==` instance method definition, we are calling the `Float#==` method on the return value of the `#gpa` getter method (the `self` here is implicit - it is being called on the object directly), and passing in the return value of the `#gpa` getter method called on the other object `student2`. It is possible to compare two `Float` objects using `Float#==`, so the method will return a boolean `true`.
```ruby
class Student
  attr_reader :gpa
  
  def initialize(gpa)
    @gpa = gpa
  end
  
  def ==(other)
    gpa == other.gpa
  end
end

student1 = Student.new(4.0)
student2 = Student.new(4.0)
p student1 == student2 # => true
```

**When do shift methods make the most sense?**
`#<<` and `#>>` can be overridden in a class definition in order to be able to customize the object's values. It makes the most sense when working with collections and especially collections that are collaborator objects within the state of the object.
For example, the `@array` instance variable that is part of the state of the `people` object below is an `Array` object. If I want to add a new object to this collection, I can override the `#<<` shift method to tell Ruby exactly where to add this new object.
```ruby
class People
  attr_reader :array

  def initialize(array)
    @array = array
  end
  
  def <<(new_object)
    @array << new_object
  end
end

people = People.new(["Someone"])
people << "Someone else"
p people.array # => ["Someone", "Someone else"]
```

**Explain how the element getter (reference) and setter methods work, and their corresponding syntactical sugar.**
The `#[]` and `#[]=` element reference getter and setter methods are actually part of Ruby's syntactical sugar, and can be overridden within a class definition in order to show Ruby which attribute it needs to reference. Here is what they look like without using the syntactical sugar:
```ruby
class Person
  def initialize(array)
    @array = array
  end
  
  def [](index)
    @array[index]
  end
  
  def []=(index, object)
    @array[index] = object
  end
end

person = Person.new(["index 0", "index 1", "index 2"])
p person[1] # => "index 1"
person[1] = 1
p person[1] # => 1
```
The `#[]` method takes one argument, the index, and the `#[]=` method takes two arguments: the index at which you want to replace a value, and the new object.
