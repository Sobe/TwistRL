require 'src/zorder'

# Represents the player's character in the maze.
class Character
  
  attr_accessor :x, :y
  
  def initialize window
    @window = window
    
    @x, @y = @window.maze.get_first_empty_square
    @window.maze.get_square(@y, @x).content << self
    @image = @window.images_loader.get_image(:player)
  end
  
  def draw
    @image.draw(@x*32, @y*32, ZOrder::Character)
  end
  
  def update
  end
  
  def move(direction)
    src_x = @x
    src_y = @y
    destination = [@x + ((direction == :right)? 1 : 0) - ((direction == :left)? 1 : 0),
                   @y + ((direction == :down)? 1 : 0) - ((direction == :up)? 1 : 0)]
    #puts "Moving to [#{destination[0]} ; #{destination[1]}]"
    if can_move_to destination
      @x, @y = destination
      @window.maze.get_square(src_y, src_x).content.delete self
      @window.maze.get_square(@y, @x).content << self
    else
      puts "Impossible to move to [#{destination[0]} ; #{destination[1]}]"
    end
  end
  
  def can_move_to(destination)
    @window.maze.contains(destination) \
      && !@window.maze.get_square(destination[1], destination[0]).is_solid
  end
  
  def move_left
    @x -= 1
  end
  
  def move_right
    @x += 1
  end
  
  def move_down
    @y += 1
  end
  
  def move_up
    @y -= 1
  end
  
end