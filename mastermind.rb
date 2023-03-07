require 'colorize'

module Colorable
  RED = 9711.chr(Encoding::UTF_8).red
  BLUE = 9711.chr(Encoding::UTF_8).blue
  GREEN = 9711.chr(Encoding::UTF_8).green
  YELLOW = 9711.chr(Encoding::UTF_8).light_yellow
  PINK = 9711.chr(Encoding::UTF_8).light_magenta
  ORANGE = 9711.chr(Encoding::UTF_8).yellow
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
    puts "| #{board[0]} | #{board[1]} | #{board[2]} | #{board[3]} | "
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

class Game
  include Colorable
  attr_accessor :game_board
  def initialize
    @game_board = Board.new
    execution
  end

  def execution
    secret_code = CodePegs.new(generate_pegs)
    secret_code.add_colored_pegs
    game_board.display_board
  end

  def generate_pegs
    [RED, BLUE, GREEN, YELLOW, PINK, ORANGE].sample(4)
  end
end

new_game = Game.new