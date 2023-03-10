require_relative './colorable'
require_relative './board'
require_relative './secret_code_pegs'
require_relative './code_pegs'
require_relative './player_choice'
require_relative './cpu_game'

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
    generate_cpu_pegs
    turn_order
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

  def generate_cpu_pegs()
    puts "\nTurn ##{@turn}"
    guess = SecretCodePegs.new
    PlayerChoice.show_choice(guess.generate_pegs)
    check = CodePegs.new(guess.generate_pegs)
    if check.check_key_pegs == true
      puts "You lost! The cpu cracked the code."
      true
    else
      puts "Right color: #{check.right_color}"
      puts "Right color and position: #{check.right_position}"
      @turn += 1
    end
  end

  def turn_order
    loop do
      if @turn == 12
        puts "\nThis is the cpu's last turn! You could win!"
      end

      if generate_cpu_pegs == true
        break
      end

      if @turn == 13
        puts "You won!! You're smarter then this piece of metal, good job!"
        break
      end
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
end


=begin


  def self.turn_order
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

=end