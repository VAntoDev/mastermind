# frozen_string_literal: true

require_relative './colorable'
require_relative './board'

# check if the playr choice is valid, converts the player choice to the color costants and shows it
class PlayerChoice < Board
  include Colorable
  attr_accessor :chosen_colors

  def initialize(chosen_colors)
    @chosen_colors = chosen_colors.collect(&:upcase)
  end

  def check_choice
    @chosen_colors = convert_to_costants
    true if chosen_colors.length == 4
  end

  def convert_to_costants
    chosen_colors.collect do |color|
      case color
      when 'R'
        RED
      when 'B'
        BLUE
      when 'G'
        GREEN
      when 'Y'
        YELLOW
      when 'P'
        PINK
      when 'O'
        ORANGE
      else
        return []
      end
    end
  end

  def self.show_choice(guess)
    player_guess = CodePegs.new(guess)
    player_game_board = Board.new
    player_guess.add_colored_pegs('human')
    player_game_board.display_board
  end
end
