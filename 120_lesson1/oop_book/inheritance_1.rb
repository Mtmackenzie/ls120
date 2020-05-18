class Vehicle
  attr_accessor :color, :year, :model
  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
  end

  def drive
    "#{@year} #{@color} #{@model} car is moving!"
  end

  def current_speed   
    "current speed: #{@speed} kph"
  end

  def speed_up(number)
    @speed += number
    "Speeding up to #{@speed} kph"
  end

  def brake(number)
    @speed -= number
    "Braking by #{number} to slow down to #{@speed} kph"
  end

  def park
    @speed = 0
    "Speed is now #{@speed} because you have parked the car."
  end

  def spray_paint(color)
    self.color = color
  end

  def self.calculate_gas_mileage(miles_driven, gallons)
    miles_driven / gallons
  end

  def to_s
    "#{year} #{model} #{color}"
  end

end

class MyCar < Vehicle

  MOTOR_SIZE = 1.8

end

class MyTruck < Vehicle

  MOTOR_SIZE = 2.4

end

my_car = MyCar.new(2016, 'red', 'Toyota Camry')
p my_car.to_s


my_truck = MyTruck.new(2009, 'black', 'Dodge Ram')
p my_truck.to_s