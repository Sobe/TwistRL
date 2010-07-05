# Abstract class representing a square of the map (ground, wall, etc...).
class Square

  attr_reader :is_solid, :ascii, :empty, :x, :y, :room, :content

  def draw
    @image.draw((@room.x * @room.width + @x) * @window.get_squares_size, \
                (@room.y * @room.height + @y) * @window.get_squares_size, \
                ZOrder::Tiles)
  end

  def rotate
    x_old = @x
    @x = @room.height - 1 - @y
    @y = x_old
    @content.each do |elt|
      elt.x = @x + @room.x * @room.width
      elt.y = @y + @room.y * @room.height
    end
  end
  
end