# Create a module named Transportation that contains three classes: Vehicle, Truck, and Car. Truck and Car should both inherit from Vehicle.

module Transportation

  class Vehicle
  end

  class Truck < Vehicle
  end
  
  class Car < Vehicle
    puts "Car instatiated"
  end
end

new_car = Transportation::Car.new