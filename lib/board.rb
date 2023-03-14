# frozen_string_literal: true

# generates the board and saves the secret code of the game
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
    puts ' _______________'
    puts "| #{board[0]} | #{board[1]} | #{board[2]} | #{board[3]} | "
    puts ' ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾'
  end

  def add_colored_pegs(player)
    case player
    when 'human'
      @@board.concat pegs_colors
    when 'cpu'
      @@board.concat chosen_colors
    end
  end

  def save_secret_code(player)
    case player
    when 'human'
      @@secret_code = pegs_colors
    when 'cpu'
      @@secret_code = chosen_colors
    end
  end
end
