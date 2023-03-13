require_relative './colorable'
class CpuCodePegs < Board
  include Colorable
  attr_accessor :pegs_colors
  @@colors_to_try = []
  @@i = 0
  @@tries = []
  def initialize
    @pegs_colors = generate_pegs
  end

  def cpu_tactic
    if @@colors_to_try.length >= 4
      new_try = @@colors_to_try.shuffle
      unless @@tries.include?(new_try)
        @@tries << new_try
        return new_try
      else
        cpu_tactic
      end
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
      @@colors_to_try = @@colors_to_try + Array.new(n_colors_to_save.to_i, pegs_colors[0])
    end
  end

  def self.classes_to_zero
    @@colors_to_try = []
    @@i = 0
    @@tries = []
  end
end