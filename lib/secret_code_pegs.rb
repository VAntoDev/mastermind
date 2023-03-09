require_relative './colorable'
class SecretCodePegs < Board
  include Colorable
  attr_accessor :pegs_colors
  def initialize
    @pegs_colors = generate_pegs
  end

  def generate_pegs
    4.times.map {[RED, BLUE, GREEN, YELLOW, PINK, ORANGE].sample}
  end
end