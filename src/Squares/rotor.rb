require 'src/zorder'
require 'src/square'

# Represents an empty square.
class Rotor < Square
  
  def initialize(window, room, x, y)
    @window = window
    @room = room
    
    @x, @y = x, y
    
    @window = window
    
    @empty = true
    @content = []
    
    # UI
    @image = @window.images_loader.get_image(:rotor)
    @ascii = "¤"
  end
  
end