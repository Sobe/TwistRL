require 'src/zorder'
require 'src/square'

# Represents an empty square.
class Herse < Square
  
  def initialize(window, room, x, y, orientation, state=:closed)
    @window = window
    @room = room
    
    @x, @y = x, y
    # :vertical or :horizontal
    @orientation = orientation
    # :closed, :opened or :broken
    @state = state
    # Depends on herse's state
    @is_solid = (@state == :closed)
    
    @window = window
    
    @empty = false
    
    # UI
    update_image
    @ascii = (@orientation == :horizontal)? "-" : "|"
  end
  
  def update_image
    id = "herse_#{(@orientation == :horizontal)? "h" : "v"}_#{@state}".to_sym
    @image = @window.images_loader.get_image(id)
  end
  
end