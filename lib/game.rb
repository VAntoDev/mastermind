require_relative './colorable'
require_relative './board'
require_relative './cpu_code_pegs'
require_relative './code_pegs'
require_relative './player_choice'
require_relative './cpu_game'
require_relative './instructions'
class Game
  include Colorable, Instructions
  attr_accessor :game_board
  def initialize
    @game_board = Board.new
    execution
  end

  def execution
    puts game_explanation
    puts 'Do you want to be the code BREAKER (1) or the code MAKER (2)?'
    who_plays = gets.chomp.to_i
    if who_plays == 1
      puts "\nYou're the code BREAKER! The cpu will generate a random code of 4 colors for you to guess."
      game_start
      @turn = 1
      turn_order
      restart
    elsif who_plays == 2
      puts "You're the code MAKER! The cpu will have to guess your secret code."
      write_code_colored
      cpu_game = CpuGame.new
    else
      puts "Incorrect input! Please retry"
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
    puts "\nTurn ##{@turn}"
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
      puts ""
      new_game = Game.new
    else
      puts "\nThanks for playing Mastermind!"
    end
  end

  def turn_order
    loop do
      if @turn == 12
        puts "\nThis is the last turn! Be careful with your choice."
      end

      if check_guess(ask_guess) == true
        break
      end

      if @turn == 13
        puts "You lost! The secret code was"
        game_board.display_board
        break
      end
    end
  end
end
