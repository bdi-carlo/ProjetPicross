load "ImgCmd.rb"
load "PicCmd.rb"

# Commande du scénario
class Instruction
  attr_reader :command

  def initialize(command)
    @command = command
  end

  def execute_command(param)
    command.execute(param)
  end
end
