require_relative './colorable'
class CodePegs < Board
  include Colorable
  attr_accessor :pegs_colors

  def initialize(pegs_colors)
    @pegs_colors = pegs_colors
  end
end