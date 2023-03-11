require_relative './colorable'
class SecretCodePegs < Board
  include Colorable
  attr_accessor :pegs_colors
  @@colors_to_try = []
  @@i = 0
  def initialize
    @pegs_colors = generate_pegs
  end

  def cpu_tactic
    if @@colors_to_try.length >= 4
      puts @@colors_to_try
      return @@colors_to_try.shuffle
    else generate_same_pegs
    end
  end

  def generate_pegs
    4.times.map {ALL_COLORS.sample}
  end

  def generate_same_pegs
    case @@i
    when 0
      @@i +=1
      [RED,RED,RED,RED]
    when 1
      @@i +=1
      [BLUE,BLUE,BLUE,BLUE]
    when 2
      @@i +=1
      [GREEN,GREEN,GREEN,GREEN]
    when 3
      @@i +=1
      [YELLOW,YELLOW,YELLOW,YELLOW]
    when 4
      @@i +=1
      [PINK,PINK,PINK,PINK]
    when 5
      @@i +=1
      [ORANGE,ORANGE,ORANGE,ORANGE]
    end
  end

  def save_colors(n_colors_to_save)
    if @@colors_to_try.length >= 4
      return @@colors_to_try
    end
    if n_colors_to_save > 0
      puts @@colors_to_try
      @@colors_to_try = @@colors_to_try + Array.new(n_colors_to_save.to_i, pegs_colors[0])
    end
    puts @@colors_to_try
  end

  #tentativo di usarlo per convertirli in costanti
  def convert_to_costants
    @@colors_to_try.collect do | color |
      case color
      when "\e[0;34;49mB\e[0m"
        color = RED
      when "\e[0;33;49mO\e[0m"
        color = BLUE
      when "\e[0;31;49mR\e[0m"
        color = GREEN
      when "\e[0;32;49mG\e[0m"
        color = YELLOW
      when "\e[0;93;49mY\e[0m"
        color = PINK
      when "\e[0;32;49mG\e[0m"
        color = ORANGE
      else
        return []
      end
    end
  end

  def self.classes_to_zero
    @@colors_to_try = []
    @@i = 0
  end
end