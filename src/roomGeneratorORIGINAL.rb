class RoomGenerator

  attr_reader :array

  @@wall = "#"
  @@void = "."
  @@h_door = "-"
  @@v_door = "|"

  def initialize(w, h)
    @width = w
    @height = h
    @array = Array.new(h)
    @array.map! do |l|
      l = Array.new(w, @@wall)
    end
    dig_walls
    anti_alias
    add_doors
  end
  
  def dig_walls
    @array.each do |line|
      line.map! do |sq|
        if rand(2) > 0
          @@void
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
          if (@array[l][c] == @@wall \
            && l != 0 && l != @height - 1 \
            && @array[l - 1][c] == @@wall \
            && @array[l + 1][c] == @@wall \
            && (@array[l][c - 1] == @@void || c == 0) \
            && (@array[l][c + 1] == @@void || c == @width - 1))
            
            @array[l][c] = @@v_door
          end
          
          # Horizontal door
          if (@array[l][c] == @@wall \
              && c != 0 && c != @width - 1 \
              && @array[l][c - 1] == @@wall \
              && @array[l][c + 1] == @@wall \
              && (l == 0 || @array[l - 1][c] == @@void) \
              && (l == @height - 1 || @array[l + 1][c] == @@void))
            
            @array[l][c] = @@h_door
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
          if get_2x2_at(l, c) == [[@@wall, @@void], [@@void, @@wall]]
            can_be_aliased = true
            if rand(2) == 1
              @array[l][c + 1] = @@wall
            else
              @array[l + 1][c] = @@wall
            end        
          end
          #~ .#
          #~ #.
          if get_2x2_at(l, c) == [[@@void, @@wall], [@@wall, @@void]]
            can_be_aliased = true
            if rand(2) == 1
              @array[l][c] = @@wall
            else
              @array[l + 1][c + 1] = @@wall
            end 
          end
        end
      end
    end
  end
  
  # Returns a 2*2 array containing squares at:
  # => [[(l, c), (l, c + 1)],
  #     [(l + 1, c), (l + 1, c + 1)]]
  def get_2x2_at(l, c)
    [[@array[l][c], @array[l][c + 1]], \
     [@array[l + 1][c], @array[l + 1][c + 1]]]
  end
  
  def ascii
    text = ""
    @array.each do |l|
      line = ""
      l.each do |sq|
        line = line + sq
      end
      text = text + line + "\n"
    end
    text.chomp
  end

end

puts RoomGenerator.new(7, 7).ascii