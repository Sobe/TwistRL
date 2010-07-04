# Abstract class representing a square of the map (ground, wall, etc...).
class Square

  attr_reader :is_solid, :ascii, :empty, :x, :y

  def draw
    @image.draw((@room.x * @room.width + @x) * @window.get_squares_size, \
                (@room.y * @room.height + @y) * @window.get_squares_size, \
                ZOrder::Tiles)
    # TODO delete print
    #~ puts "Trying to draw square at:[#{@room.x * @room.width + @x * @@SQUARE_SIZE}, " + \
                                    #~ "#{@room.y * @room.height + @y * @@SQUARE_SIZE}]"
  end
  
end