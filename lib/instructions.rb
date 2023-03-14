# frozen_string_literal: true

require_relative './colorable'

# explains how the game works to the player
module Instructions
  include Colorable
  def game_explanation
    <<~HEREDOC
      This is mastermind! A single player game against the computer.
      You can play as the BREAKER or the MAKER.

      There are six colors:
      #{RED} #{BLUE} #{GREEN} #{YELLOW} #{PINK} #{ORANGE}

      As the BREAKER your job is to guess the master code which is a combination of four colors
      between the six that the MAKER can choose from.

      This is an example of master code:
       _______________
      | #{RED} | #{YELLOW} | #{RED} | #{BLUE} |
       ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
      As you can see duplicates are allowed!

      Then the BREAKER will make their guesses, with every guess the code will give some hints 
      on the master code. Lets say you want to try a guess like 'R P B Y'
       _______________
      | #{RED} | #{PINK} | #{BLUE} | #{YELLOW} |
       ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
      Right color: 3
      Right color and position: 1

      The guess had 3 right colors and 1 right color in the right position.

      Now lets play some Mastermind!
      +---+
    HEREDOC
  end
end
