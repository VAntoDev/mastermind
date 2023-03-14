# frozen_string_literal: true

require_relative './colorable'

# handles the cpu's tactic during the game and generates its pegs
class CpuCodePegs < Board
  include Colorable
  attr_accessor :pegs_colors

  @@colors_to_try = []
  @@i = -1
  @@tries = []
  def initialize
    @pegs_colors = generate_pegs
  end

  def cpu_tactic
    if @@colors_to_try.length >= 4
      exclude_used_combinations
    else
      generate_same_pegs
    end
  end

  def exclude_used_combinations
    new_try = @@colors_to_try.shuffle
      if @@tries.include?(new_try)
        cpu_tactic
      else
        @@tries << new_try
        new_try
      end
  end

  def generate_pegs
    4.times.map { ALL_COLORS.sample }
  end

  def generate_same_pegs
    @@i += 1
    Array.new(4, ALL_COLORS[@@i])
  end

  def save_colors(n_colors_to_save)
    if @@colors_to_try.length >= 4
      return @@colors_to_try
    end

    @@colors_to_try += Array.new(n_colors_to_save.to_i, pegs_colors[0]) if n_colors_to_save.positive?
  end

  def self.tries_to_zero
    @@colors_to_try = []
    @@i = -1
    @@tries = []
  end
end
