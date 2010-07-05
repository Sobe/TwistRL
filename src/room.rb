require 'src/square'
require 'gosu'

require 'src/zorder'

# This class represents a room, i.e. a set of squares.
# See classes *Maze* and *Square*
class Room
  
  attr_reader :x, :y, :squares, :width, :height
  
  def initialize(window, width, height, x, y)
    @x, @y = x, y
    @width, @height = width, height
    @window = window
    
    @squares = Array.new(@height) do |l|
      Array.new(@width) do |c|
        Ground.new(window, self, c, l)
      end
    end
  end
  
  def fill_with square_class
    @squares.each do |l|
      l.map! do |sq|
        square_class.new(@window, self, sq.x, sq.y)
      end
    end
  end
  
  def draw
    # Draw squares
    @squares.each do |line|
      line.each do |sq|
        sq.draw
      end
    end
    # Draw border lines
    #draw_line(x1, y1, c1, x2, y2, c2, z=0, mode=:default)
    black_color = Gosu::Color.new(255, 0, 0, 0)
    @window.draw_line(@x*@width*@window.get_squares_size, @y*@height*@window.get_squares_size, black_color, \
                     (@x + 1)*@width*@window.get_squares_size, @y*@height*@window.get_squares_size, black_color, \
                      ZOrder::Room_Border)
    @window.draw_line((@x + 1)*@width*@window.get_squares_size, @y*@height*@window.get_squares_size, black_color, \
                     (@x + 1)*@width*@window.get_squares_size, (@y + 1)*@height*@window.get_squares_size, black_color, \
                      ZOrder::Room_Border)
    @window.draw_line((@x + 1)*@width*@window.get_squares_size, (@y + 1)*@height*@window.get_squares_size, black_color, \
                      @x*@width*@window.get_squares_size, (@y + 1)*@height*@window.get_squares_size, black_color, \
                      ZOrder::Room_Border)
    @window.draw_line(@x*@width*@window.get_squares_size, (@y + 1)*@height*@window.get_squares_size, black_color, \
                      @x*@width*@window.get_squares_size, @y*@height*@window.get_squares_size, black_color, \
                      ZOrder::Room_Border)
  end
  
  def print_ascii
    @squares.each do |line|
      l = ""
      line.each do |sq|
        l = l + sq.ascii
      end
      puts l
    end
  end
  
  # Rotates room in direct sense.
  # Also updates accordingly each contained square.
  def rotate
    # Rotated room
    @rotated = Array.new(@height) do |l|
      Array.new(@width) do |c|
        nil
      end
    end
    
    @squares.each do |line|
      line.each do |sq|
        @rotated[sq.x][@height -1 - sq.y] = sq
        sq.rotate
      end
    end
    
    @squares = @rotated
  end
  
  def get_first_empty_square
    @squares.each do |line|
      line.each do |square|
        return [square.x, square.y] if square.empty
      end
    end
  end
    
  
end