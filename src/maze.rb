# require 'src/squares.rb'
require 'src/roomGenerator'

# Represents the maze where the player is.
# It contains a 2D array of rooms (see class Room).
class Maze
  
  attr_reader :squares

  # width and height in _rooms_
  def initialize(window, width, height, rooms_width, rooms_height)
    @window = window
    @width, @height = width, height
    @rooms_width, @rooms_height = rooms_width, rooms_height

    # Create RoomGenerator
    generator = RoomGenerator.new(@window, @rooms_width, @rooms_height)
    
    @rooms = Array.new(@height) do |l|
      Array.new(@width) do |c|
        generator.generate_room(c, l)
      end
    end
    
    puts "Created maze of #{@width}*#{@height} rooms."
    puts "=> #{@width*@rooms_width}*#{@height*@rooms_height} squares"
  end
  
  def draw
    @rooms.each do |line_room|
      line_room.each do |room|
        room.draw
      end
    end
  end
  
  def contains destination
    destination[0] >= 0 && destination[0] < @width*@rooms_width \
      && destination[1] >= 0 && destination[1] < @height*@rooms_height
  end
    
  def get_first_empty_square
    @rooms.each do |rooms_line|
      rooms_line.each do |room|
        room.squares.each do |line|
          line.each do |square|
            return [@rooms_width*room.x + square.x, @rooms_height*room.y + square.y] if square.empty
          end
        end
      end
    end
  end
  
  def get_square(l, c)
    @rooms[l / @rooms_height][c / @rooms_width].squares[l % @rooms_height][c % @rooms_width]
  end
  
end