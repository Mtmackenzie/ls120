class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

apple = Fruit.new('apple')
hawaiian = Pizza.new('hawaiian')

p apple.instance_variables
p hawaiian.instance_variables