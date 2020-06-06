class Cube
  attr_reader :volume
  def initialize(volume)
    @volume = volume
  end
end

new_cube = Cube.new(30)

p new_cube.volume