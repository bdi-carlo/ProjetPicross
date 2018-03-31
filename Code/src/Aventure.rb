load "Scenario.rb"
load "ScenarioCmd.rb"
class Aventure
  def initialize(pseudo)
    scenar = ScenarioUI.new
    cmd = ScenarioCmd.new(scenar)
    cmd.use_cmd(:img,"../images/scenario/Scenario1_1_1.png")
    cmd.use_cmd(:img,"../images/scenario/Scenario1_1_2.png")
    cmd.use_cmd(:pic,[pseudo,"../grilles/scenario/Pont",1,0])
    cmd.use_cmd(:img,"../images/scenario/Scenario1_1_3.png")
    cmd.use_cmd(:img,"../images/scenario/Scenario1_2_1.png")
    cmd.use_cmd(:pic,[pseudo,"../grilles/scenario/Echelle",1,0])
    cmd.use_cmd(:img,"../images/scenario/Scenario1_2_2.png")
    cmd.use_cmd(:img,"../images/scenario/Scenario1_2_3.png")
    cmd.use_cmd(:img,"../images/scenario/Scenario1_3_1.png")
    cmd.use_cmd(:img,"../images/scenario/Scenario1_3_2.png")
    cmd.use_cmd(:img,"../images/scenario/Scenario1_3_3.png")
    cmd.use_cmd(:img,"../images/scenario/Scenario1_3_4.png")
    #cmd.use_cmd(:pic,["./Echelle",1,0])
    cmd.use_cmd(:img,"../images/scenario/Scenario1_4_1.png")
    cmd.use_cmd(:img,"../images/scenario/Scenario1_4_2.png")
    cmd.use_cmd(:pic,[pseudo,"../grilles/scenario/Bateau",-1,800])
    cmd.use_cmd(:img,"../images/scenario/Scenario1_4_3.png")

  end
end
