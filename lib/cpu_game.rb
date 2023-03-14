# frozen_string_literal: true

require_relative './colorable'
require_relative './board'
require_relative './cpu_code_pegs'
require_relative './code_pegs'
require_relative './player_choice'
require_relative './cpu_game'

# handles the cpu's game execution and asks the player for the master code
class CpuGame
  attr_accessor :game_board

  include Colorable
  def initialize
    @game_board = Board.new
    execution
  end

  def execution
    game_start
    @turn = 1
    turn_order unless generate_cpu_pegs == true
    restart
  end

  def game_start
    secret_code = ask_secret_code
    secret_code.chosen_colors
    secret_code.add_colored_pegs('cpu')
    secret_code.save_secret_code('cpu')
    game_board.display_board
    puts "Secret code generated, lets start!\n"
  end

  def ask_secret_code
    secret_code = PlayerChoice.new(gets.chomp.split)
    if secret_code.check_choice == true
      secret_code
    else
      puts "\nInput error! Remember to follow the example."
      write_code_colored
      ask_secret_code
    end
  end

  def generate_cpu_pegs
    puts "\nTurn ##{@turn}"
    guess = CpuCodePegs.new
    cpu_guess = guess.cpu_tactic
    PlayerChoice.show_choice(cpu_guess)
    check = CodePegs.new(cpu_guess)
    if check.check_key_pegs == true
      puts 'You lost! The cpu cracked the code.'
      true
    else
      puts "Right color: #{check.right_color}"
      guess.pegs_colors = cpu_guess
      guess.save_colors(check.right_color)
      puts "Right color and position: #{check.right_position}"
      @turn += 1
      sleep(2)
    end
  end

  def turn_order
    loop do
      puts "\nThis is the cpu's last turn! You could win!" if @turn == 12

      break if generate_cpu_pegs == true

      if @turn == 13
        puts "You won!! You're smarter than this program, good job!"
        break
      end
    end
  end

  def restart
    puts 'Do you want to play again? Press Y to play again'
    CpuCodePegs.tries_to_zero
    if gets.chomp.upcase == 'Y'
      puts ''
      Game.new
    else
      puts "\nThanks for playing Mastermind!"
    end
  end
end
