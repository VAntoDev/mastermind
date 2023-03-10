module Colorable
  RED = "R".red
  BLUE = "B".blue
  GREEN = "G".green
  YELLOW = "Y".light_yellow
  PINK = "P".light_magenta
  ORANGE = "O".yellow

  def write_code_colored
    puts "Write down here your code, choose four colors between " + "Red(R) ".red + "Green(G) ".green + "Blue(B) ".blue + "Yellow(Y) ".light_yellow + "Pink(P) ".light_magenta + "Orange(O)".yellow + '. Example: R P B G'
  end
end