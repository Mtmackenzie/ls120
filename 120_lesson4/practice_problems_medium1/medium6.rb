# class Computer
#   attr_accessor :template

#   def create_template
#     @template = "template 14231"  # instance variable that is assigned to a string object
#   end

#   def show_template
#     template  # template getter method, will return whatever @template returns if it has been initialized, will return nil unless create_template is called
#   end
# end


class Computer
  attr_accessor :template

  def create_template
    self.template = "template 14231" 
  end

  def show_template
    self.template  # return value of create template if it has been called. 
  end
end

mac = Computer.new
p mac.create_template
p mac.show_template

# The first example is reassigning the instance variable, and the second one is reassigning the return value of the method itself. The first one is preferred because it is not necessary to use self here.