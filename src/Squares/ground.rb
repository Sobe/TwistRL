require 'src/zorder'
require 'src/square'

# Represents an empty square.
class Ground < Square
  
  attr_accessor :x, :y
  
  def initialize(window, room, x, y)
    @window = window
    @room = room
    
    @x, @y = x, y
    @is_solid = false
    
    @empty = true
    
    # UI
    @image = @window.images_loader.get_image(:ground)
    @ascii = "."
  end
  
end