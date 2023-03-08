require_relative "./colorable"
class PlayerChoice
  include Colorable
  attr_accessor :chosen_colors
  
  def initialize(chosen_colors)
    @chosen_colors = chosen_colors.collect { |x| x.upcase }
  end
  
  def check_choice
    @chosen_colors = convert_to_costants
    true if chosen_colors.uniq.length == 4
  end

  def convert_to_costants
    chosen_colors.collect do | color |
      case color
      when 'R'
        color = RED
      when 'B'
        color = BLUE
      when 'G'
        color = GREEN
      when 'Y'
        color = YELLOW
      when 'P'
        color = PINK
      when 'O'
        color = ORANGE
      else
        return []
      end
    end
  end
end
  