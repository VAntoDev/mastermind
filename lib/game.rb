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
    @turn = 1
    loop do
      if @turn == 12
        puts "\nThis is the last turn! Be careful with your choice."
      end

      puts "\nTurn ##{@turn}"
      if check_guess(ask_guess) == true
        break
      end

      if @turn == 13
        puts "You lost! The secret code was"
        game_board.display_board
        break
      end
    end
    restart
  end

  def game_start
    secret_code = SecretCodePegs.new
    secret_code.add_colored_pegs
    secret_code.save_secret_code
    puts "Secret code generated, lets start!\n"
  end

  def ask_guess
    puts "Write here your guess, choose four colors between Red(R), Green(G), Blue(B), Yellow(Y), Pink(P), Orange(O). Example: R P B G"
    guess = PlayerChoice.new(gets.chomp.split)
    if guess.check_choice == true
      guess.chosen_colors
    else
      puts "Input error! Remember to follow the example."
      puts "+-------------------------------------------------------------------------------+\n "
      ask_guess
    end
  end

  def check_guess(guess)
    puts "Your guess is: "
    PlayerChoice.show_choice(guess)
    check = CodePegs.new(guess)
    if check.check_key_pegs == true
      puts "You won!"
      true
    else
      puts "Right color: #{check.right_color}"
      puts "Right color and position: #{check.right_position}"
      @turn += 1
    end
  end

  def restart
    puts "Do you want to play again? Press Y to play again"
    if gets.chomp.upcase == "Y"
      new_game = Game.new
    else
      puts "\nThanks for playing Mastermind!"
    end
  end
end
