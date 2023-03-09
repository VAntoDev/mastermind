require_relative './colorable'
class CodePegs < Board
  include Colorable
  attr_accessor :pegs_colors, :right_color, :right_position

  def initialize(pegs_colors)
    @pegs_colors = pegs_colors
    @right_color = 0
    @right_position = 0
  end

  def check_key_pegs
    secret_copy = []
    secret_copy = secret_copy + @@secret_code
    if pegs_colors == @@secret_code
      true
    else
      secret_copy.each_with_index do | secret_color, index |
        if secret_color == pegs_colors[index] #right color and position
          @right_position = @right_position + 1
        end
      end
      pegs_colors.each_with_index do | peg_color, index |
        if secret_copy.include?(peg_color) #right color
          @right_color = @right_color + 1
          secret_copy.delete_at(secret_copy.index(peg_color))
        end
      end
    end
  end
end