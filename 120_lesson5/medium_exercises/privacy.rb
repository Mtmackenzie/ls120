# Consider the following class:

class Machine
  def to_s
    "machine is #{switch}"
  end

  def start
    flip_switch(:on)
  end

  def stop
    flip_switch(:off)
  end

  private
  attr_accessor :switch

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

machine = Machine.new
puts machine.start
# puts machine.stop
puts machine

# Modify this class so both flip_switch and the setter method switch= are private methods.