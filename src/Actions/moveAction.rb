# Action of moving the character in one direction (LRUD).
class MoveAction
  
  def initialize(charact, direction)
    @character = charact
    @move_method = @character.method("move")
    @direction = direction
  end
  
  def execute
    @move_method.call(@direction)
  end
  
end