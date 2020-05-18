# Create a class 'Student' with attributes name and grade. Do NOT make the grade getter public, so joe.grade will raise an error. Create a better_grade_than? method, that you can call like so...

# puts "Well done!" if joe.better_grade_than?(bob)

class Student
  attr_accessor :name
  attr_reader :grade

  def initialize(n, g)
    @name = n
    @grade = g
  end

  def better_grade_than?(other)
    if @grade > other.grade
      puts "Well done! You did better than #{other.name}"
    else
      puts "Work hard and you will soon be at the top of your class!"
    end
  end

end

bob = Student.new("Bob", 70)
joe = Student.new("Joe", 60)

joe.better_grade_than?(bob)