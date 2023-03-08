require 'colorize'

module Colorable
  RED = "R".red
  BLUE = "B".blue
  GREEN = "G".green
  YELLOW = "Y".light_yellow
  PINK = "P".light_magenta
  ORANGE = "O".yellow
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

  def add_colored_pegs
    @@board = @@board.concat pegs_colors
  end

  def save_secret_code
    @@secret_code = pegs_colors
  end
end

class CodePegs < Board
  include Colorable
  attr_accessor :pegs_colors

  def initialize(pegs_colors)
    @pegs_colors = pegs_colors
  end
end

class SecretCodePegs < Board
  include Colorable
  attr_accessor :pegs_colors
  def initialize
    @pegs_colors = generate_pegs
  end

  def generate_pegs
    [RED, BLUE, GREEN, YELLOW, PINK, ORANGE].sample(4)
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
    puts 'This is Mastermind! Guess the 4 colors of the random secret code to win!'
    game_start
    check_guess(ask_guess)
  end

  def game_start
    secret_code = SecretCodePegs.new
    secret_code.add_colored_pegs
    secret_code.save_secret_code
    game_board.display_board
    puts "Secret code generated, lets start!\n"
  end

  def ask_guess
    puts "\nWrite here your guess, choose four colors between Red(R), Green(G), Blue(B), Yellow(Y), Pink(P), Orange(O). Example: R P B G"
    puts "REMEMBER! Duplicates aren't allowed."
    guess = PlayerChoice.new(gets.chomp.split)
    if guess.check_choice == true
      guess.chosen_colors
    else
      puts "Input error! Remember, don't write a color more than once and follow the example."
      ask_guess
   end
  end

  def check_guess(guess)
    player_guess = CodePegs.new(guess)
    player_guess.add_colored_pegs
    game_board.display_board
    puts "Your guess is: " 
  end
end

class PlayerChoice
attr_accessor :chosen_colors

  def initialize(chosen_colors)
    @chosen_colors = chosen_colors
  end

  def check_choice
    true if chosen_colors.uniq.length == 4
  end
end


new_game = Game.new