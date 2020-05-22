# What Will This Do?
# What will the following code print?

class Something
  def initialize
    @data = 'Hello'
  end

  def dupdata
    @data + @data
  end

  def self.dupdata
    'ByeBye'
  end
end

thing = Something.new
puts Something.dupdata  # class method, 'ByeBye'
puts thing.dupdata   # instance method, "HelloHello"