require 'colorize'


module Colorable
  RED = "RED".red
  BLUE = "BLUE".blue
  GREEN = "GREEN".green
  YELLOW = "YELLOW".yellow
  PINK = "PINK".magenta
  ORANGE = "ORANGE".light_red
end

class Board
  attr_accessor :board

  def initialize
    @board = []
    current_board
  end

  def current_board
    @@board = @board
  end

  def display_board
    print "| #{board[0]} | #{board[1]} | #{board[2]} | #{board[3]} | "
  end
end

class CodePegs < Board
  include Colorable
  attr_accessor :pegs_colors

  def initialize(pegs_colors)
    @pegs_colors = pegs_colors
  end

  def add_colored_pegs
    @@board = @@board.concat pegs_colors
  end

end

include Colorable
new_board = Board.new
new_peg = CodePegs.new([ORANGE, PINK, BLUE, RED])
new_peg.add_colored_pegs
new_board.display_board