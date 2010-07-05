require 'src/squares'
require 'src/room'

# A generator of rooms.
# See *Room* class
class RoomGenerator

  attr_reader :array

  def initialize(window, w, h)
    @window = window
    @width = w
    @height = h
    #~ @room = Room.new(w, h)
    #~ dig_walls
    #~ anti_alias
    #~ add_doors
  end
  
  # Generate a new Room at [x, y].
  def generate_room(x, y)
    @room = Room.new(@window, @width, @height, x, y)
    fill_with_walls
    dig_walls
    anti_alias
    add_doors
    add_a_rotor
    
    #~ @room.print_ascii
    #~ puts ""
    #~ puts
    
    return @room
  end
  
  def fill_with_walls
    @room.fill_with(Wall)
  end
  
  def dig_walls
    @room.squares.each do |line|
      line.map! do |sq|
        if rand(3) > 0
          Ground.new(@window, @room, sq.x, sq.y)
        else
          sq
        end
      end
    end
  end
  
  def add_doors
    for l in 0...@height
      for c in 0...@width
        if rand(10) > 2
          # Vertical door
          if (@room.squares[l][c].class == Wall \
            && l != 0 && l != @height - 1 \
            && @room.squares[l - 1][c].class == Wall \
            && @room.squares[l + 1][c].class == Wall \
            && (@room.squares[l][c - 1].class == Ground || c == 0) \
            && (@room.squares[l][c + 1].class == Ground || c == @room.width - 1))
            
            @room.squares[l][c] = Herse.new(@window, @room, c, l, :vertical)
          end
          
          # Horizontal door
          if (@room.squares[l][c].class == Wall \
              && c != 0 && c != @width - 1 \
              && @room.squares[l][c - 1].class == Wall \
              && @room.squares[l][c + 1].class == Wall \
              && (l == 0 || @room.squares[l - 1][c].class == Ground) \
              && (l == @room.height - 1 || @room.squares[l + 1][c].class == Ground))
            
            @room.squares[l][c] = Herse.new(@window, @room, c, l, :horizontal)
          end
        end
      end
    end
  end
  
  def anti_alias
    can_be_aliased = true
    
    while can_be_aliased
      can_be_aliased = false
      for l in 0...@height - 1
        for c in 0...@width - 1
          # Look for patterns:
          #~ #.
          #~ .#
          if get_2x2_at(l, c) == [[Wall, Ground], [Ground, Wall]]
            can_be_aliased = true
            if rand(2) == 1
              @room.squares[l][c + 1] = Wall.new(@window, @room, c + 1, l)
            else
              @room.squares[l + 1][c] = Wall.new(@window, @room, c, l + 1)
            end        
          end
          #~ .#
          #~ #.
          if get_2x2_at(l, c) == [[Ground, Wall], [Wall, Ground]]
            can_be_aliased = true
            if rand(2) == 1
              @room.squares[l][c] = Wall.new(@window, @room, c, l)
            else
              @room.squares[l + 1][c + 1] = Wall.new(@window, @room, c + 1, l + 1)
            end 
          end
        end
      end
    end
  end
  
  def add_a_rotor
    c, l = @room.get_first_empty_square
    @room.squares[l][c] = Rotor.new(@window, @room, c, l)
  end
  
  # Returns a 2*2 array containing squares' classes at:
  # => [[(l, c), (l, c + 1)],
  #     [(l + 1, c), (l + 1, c + 1)]]
  def get_2x2_at(l, c)
    [[@room.squares[l][c].class, @room.squares[l][c + 1].class], \
     [@room.squares[l + 1][c].class, @room.squares[l + 1][c + 1].class]]
  end
  
  def ascii
    text = ""
    @room.squares.each do |l|
      line = ""
      l.each do |sq|
        line = line + sq.ascii
      end
      text = text + line + "\n"
    end
    text.chomp
  end

end

#puts RoomGenerator.new(7, 7).ascii