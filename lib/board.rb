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
    puts " _______________"
    puts "| #{board[0]} | #{board[1]} | #{board[2]} | #{board[3]} | "
    puts " ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾"
  end

  def add_colored_pegs(player)
    if player == "human"
      @@board = @@board.concat pegs_colors
    elsif player == "cpu"
      @@board = @@board.concat chosen_colors
    end
  end

  def save_secret_code(player)
    if player == "human"
      @@secret_code = pegs_colors
    elsif player == "cpu"
      @@secret_code = chosen_colors
    end
  end
end