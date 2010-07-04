require 'gosu'
include Gosu

require 'src/actions'
require 'src/character'

class KeysManager
  
  def initialize(charac)
    @character = charac
    
    @action_for_key_up = init_actions_key_up
  end
  
  def init_actions_key_up
    {
      Gosu::Button::KbRight => MoveAction.new(@character, :right),
      Gosu::Button::KbLeft => MoveAction.new(@character, :left),
      Gosu::Button::KbUp => MoveAction.new(@character, :up),
      Gosu::Button::KbDown => MoveAction.new(@character, :down),
    }
  end
  
  
  def key_up(id)
    @action_for_key_up[id].execute if @action_for_key_up.include? id
  end
  
  
  
end
