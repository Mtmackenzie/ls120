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

  def to_s
    name
  end

end

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"