require 'rubygems'
require 'gosu'

require 'src/keysManager'
require 'src/character'
require 'src/maze'
require 'src/imagesLoader'

include Gosu

# Main game's window.
class GameWindow < Window
  
  attr_reader :maze, :images_loader
  
  @@SQUARE_SIZE = 32

  def initialize 
    super(672, 448, false)
    self.caption = "TwistRL"
    
    # Images loader
    @images_loader = ImagesLoader.new self
    # Maze
    width = 3
    height = 2
    @maze = Maze.new(self, width, height, 7, 7)
    
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
  
  def get_squares_size
    @@SQUARE_SIZE
  end
  
end

GameWindow.new.show
