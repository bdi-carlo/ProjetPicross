load "ImgCmd.rb"
load "PicCmd.rb"
load "AskCmd.rb"
load "Instruction.rb"
class ScenarioCmd


  def initialize(scenario)
    @scenar = scenario
    @buttons = {
      img: Instruction.new(ImgCmd.new(scenario)),
      pic: Instruction.new(PicCmd.new(scenario)),
      ask: Instruction.new(AskCmd.new(scenario))
    }
  end

  def use_cmd(nom,param)
    instruction(nom).execute_command(param)
  end

  private
  def instruction(name)
    @buttons.fetch name
  end
end
