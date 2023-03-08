require_relative './colorable'
require_relative './board'
require_relative './secret_code_pegs'
require_relative './code_pegs'
require_relative './player_choice'
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
      puts "+-------------------------------------------------------------------------------+\n "
      ask_guess
    end
  end

  def check_guess(guess)
    puts "Your guess is: "
    player_guess = CodePegs.new(guess)
    player_game_board = Board.new
    player_guess.add_colored_pegs
    player_game_board.display_board
  end
end
