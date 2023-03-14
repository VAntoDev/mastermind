# frozen_string_literal: true

require_relative './colorable'

# generates the pegs colors and checks if the chosen ones match with the master code
class CodePegs < Board
  include Colorable
  attr_accessor :pegs_colors, :right_color, :right_position

  def initialize(pegs_colors)
    @pegs_colors = pegs_colors
    @right_color = 0
    @right_position = 0
  end

  def check_key_pegs
    @secret_copy = []
    @secret_copy += @@secret_code
    if pegs_colors == @@secret_code
      true
    else
      check_color
      check_color_and_position
    end
  end

  def check_color
    @secret_copy.each_with_index do |secret_color, index|
      @right_position += 1 if secret_color == pegs_colors[index]
    end
  end

  def check_color_and_position
    pegs_colors.each_with_index do |peg_color, _index|
      if @secret_copy.include?(peg_color)
        @right_color += 1
        @secret_copy.delete_at(@secret_copy.index(peg_color))
      end
    end
  end
end
