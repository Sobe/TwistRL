# Action of rotating the current room.
# Needs to be on a rotor.
class RotateAction
  
  def initialize(maze, charact)
    @character = charact
    @maze = maze
  end
  
  def execute
    if @maze.get_square(@character.y, @character.x).class == Rotor
      @maze.get_square(@character.y, @character.x).room.rotate
    end
  end
  
end