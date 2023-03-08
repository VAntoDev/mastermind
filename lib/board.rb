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

  def add_colored_pegs
    @@board = @@board.concat pegs_colors
  end

  def save_secret_code
    @@secret_code = pegs_colors
  end
end