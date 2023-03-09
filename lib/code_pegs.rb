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
    puts pegs_colors
    puts @@secret_code
    if pegs_colors == @@secret_code
      true
    else
      secret_copy = @@secret_code
      secret_copy.each_with_index do | secret_color, index |
        if secret_copy.uniq.include?(pegs_colors[index]) #right color (not working correctly)
          @right_color = @right_color + 1
          if secret_color == pegs_colors[index] #right color and position (working)
            @right_position = @right_position + 1
          end
        end
      end
    end
  end
end