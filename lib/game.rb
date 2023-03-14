# frozen_string_literal: true

require_relative './colorable'
require_relative './board'
require_relative './cpu_code_pegs'
require_relative './code_pegs'
require_relative './player_choice'
require_relative './cpu_game'
require_relative './instructions'

# handles the execution of the game interacting with the player inputs
class Game
  include Colorable
  include Instructions
  attr_accessor :game_board

  def initialize
    @game_board = Board.new
    execution
  end

  def execution
    puts game_explanation
    puts 'Do you want to be the code BREAKER (1) or the code MAKER (2)?'
    who_plays = gets.chomp.to_i
    case who_plays
    when 1
      puts "\nYou're the code BREAKER! The cpu will generate a random code of 4 colors for you to guess."
      game_start
      @turn = 1
      turn_order
      restart
    when 2
      puts "You're the code MAKER! The cpu will have to guess your secret code."
      write_code_colored
      CpuGame.new
    else
      puts "+---Incorrect input! Please retry!---+\n\n\n"
      execution
    end
  end

  def game_start
    secret_code = CpuCodePegs.new
    secret_code.add_colored_pegs('human')
    secret_code.save_secret_code('human')
    puts "Secret code generated, lets start!\n"
    write_code_colored
  end

  def ask_guess
    guess = PlayerChoice.new(gets.chomp.split)
    if guess.check_choice == true
      guess.chosen_colors
    else
      puts "\nInput error! Remember to follow the example."
      write_code_colored
      ask_guess
    end
  end

  def check_guess(guess)
    puts "\nTurn ##{@turn}\nYour guess is:"
    PlayerChoice.show_choice(guess)
    check = CodePegs.new(guess)
    if check.check_key_pegs == true
      puts 'You won!'
      true
    else
      puts "Right color: #{check.right_color}\nRight color and position: #{check.right_position}\nNext guess:"
      @turn += 1
    end
  end

  def restart
    puts 'Do you want to play again? Press Y to play again'
    if gets.chomp.upcase == 'Y'
      puts ''
      Game.new
    else
      puts "\nThanks for playing Mastermind!"
    end
  end

  def turn_order
    loop do
      puts "\nThis is the last turn! Be careful with your choice." if @turn == 12

      break if check_guess(ask_guess) == true

      if @turn == 13
        puts 'You lost! The secret code was'
        game_board.display_board
        break
      end
    end
  end
end
