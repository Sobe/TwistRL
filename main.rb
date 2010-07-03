require 'rubygems'
require 'gosu'

require 'src/keysManager'
require 'src/character'
require 'src/maze'

include Gosu

# Main game's widow.
class Game < Window
  
  attr_reader :maze

  def initialize    
    super(640, 320, false)
    self.caption = "TwistRL"
    
    # Maze
    width = 20
    height = 10
    @maze = Maze.new(self, width, height)
    
    # Player's character
    @character = Character.new(self)
    
    # Keys manager
    @key_manager = KeysManager.new @character
  end
  
  def update
    @character.update
  end
  
  def draw
    @character.draw
    @maze.draw
  end
  
  def button_down(id)
    if id == Button::KbEscape then 
      close
    end
  end
  
  def button_up(id)
    @key_manager.key_up(id)
  end
  
end

Game.new.show
