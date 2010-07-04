require 'src/zorder'
require 'src/square'

# Represents a wall square.
class Wall < Square
  
  def initialize(window, room, x, y)
    @window = window
    @room = room
    
    @x, @y = x, y
    @is_solid = true
    
    @empty = false
    
    # UI
    @image = @window.images_loader.get_image(:wall)
    @ascii = "#"
  end
  
end
