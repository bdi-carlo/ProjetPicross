load "Scenario.rb"
load "ScenarioCmd.rb"
require 'gtk3'
#Invocateur du Scénario
class Aventure
  ##
  # Initialise la fonction
  #
  # Param : Pseudo du joueur
  def initialize(pseudo)
    scenar = ScenarioUI.new
    @window = Gtk::Window.new()
    event=Gtk::EventBox.new()
    @window.add(event)
    @window.set_size_request(970, 700)
    @window.resizable=FALSE
    @window.set_window_position(:center_always)
    @window.set_title("Picross")
    @window.border_width=10
    @window.signal_connect('destroy') {onDestroy}
    cmd = ScenarioCmd.new(scenar)
    # :img pour une image :pic pour un picross
    cmd.use_cmd(:img,["../images/scenario/Scenario1_1_1.png",@window])
    cmd.use_cmd(:img,["../images/scenario/Scenario1_1_2.png",@window])
    cmd.use_cmd(:pic,[pseudo,"../grilles/scenario/Pont",1,0])
    cmd.use_cmd(:img,["../images/scenario/Scenario1_1_3.png",@window])
    cmd.use_cmd(:img,["../images/scenario/Scenario1_2_1.png",@window])
    cmd.use_cmd(:pic,[pseudo,"../grilles/scenario/Echelle",1,0])
    cmd.use_cmd(:img,["../images/scenario/Scenario1_2_2.png",@window])
    cmd.use_cmd(:img,["../images/scenario/Scenario1_2_3.png",@window])
    cmd.use_cmd(:img,["../images/scenario/Scenario1_3_1.png",@window])
    cmd.use_cmd(:img,["../images/scenario/Scenario1_3_2.png",@window])
    cmd.use_cmd(:img,["../images/scenario/Scenario1_3_3.png",@window])
    cmd.use_cmd(:img,["../images/scenario/Scenario1_3_4.png",@window])
    cmd.use_cmd(:pic,[pseudo,"../grilles/scenario/cle",1,0])
    cmd.use_cmd(:img,["../images/scenario/Scenario1_4_1.png",@window])
    cmd.use_cmd(:img,["../images/scenario/Scenario1_4_2.png",@window])
    cmd.use_cmd(:pic,[pseudo,"../grilles/scenario/Bateau",-1,800])
    cmd.use_cmd(:img,["../images/scenario/Scenario2_1_1.png",@window])
    cmd.use_cmd(:img,["../images/scenario/Scenario2_1_2.png",@window])
    cmd.use_cmd(:pic,[pseudo,"../grilles/scenario/doubleFish",1,0])
    cmd.use_cmd(:img,["../images/scenario/Scenario2_1_3.png",@window])
    cmd.use_cmd(:img,["../images/scenario/Scenario2_1_4.png",@window])
    cmd.use_cmd(:img,["../images/scenario/Scenario2_2_1.png",@window])
    cmd.use_cmd(:img,["../images/scenario/Scenario2_2_2.png",@window])
    cmd.use_cmd(:pic,[pseudo,"../grilles/scenario/pirateFlag",1,0])
    cmd.use_cmd(:img,["../images/scenario/Scenario2_3_1.png",@window])
    cmd.use_cmd(:img,["../images/scenario/Scenario2_3_2.png",@window])
    cmd.use_cmd(:img,["../images/scenario/Scenario2_3_3.png",@window])
    cmd.use_cmd(:pic,[pseudo,"../grilles/scenario/anchor",1,0])
    cmd.use_cmd(:img,["../images/scenario/Scenario2_4_1.png",@window])
    cmd.use_cmd(:img,["../images/scenario/Scenario2_4_2.png",@window])
    cmd.use_cmd(:pic,[pseudo,"../grilles/scenario/Qrvent",-1,800])
    cmd.use_cmd(:img,["../images/scenario/Scenario2_4_3.png",@window])
    cmd.use_cmd(:img,["../images/scenario/Scenario3_1_1.png",@window])
    cmd.use_cmd(:img,["../images/scenario/Scenario3_1_2.png",@window])
    cmd.use_cmd(:img,["../images/scenario/Scenario3_1_3.png",@window])
    cmd.use_cmd(:pic,[pseudo,"../grilles/scenario/labyrinthe",1,0])
    cmd.use_cmd(:img,["../images/scenario/Scenario3_2_1.png",@window])
    cmd.use_cmd(:pic,[pseudo,"../grilles/scenario/castle",1,0])
    cmd.use_cmd(:img,["../images/scenario/Scenario3_2_2.png",@window])
    cmd.use_cmd(:img,["../images/scenario/Scenario3_3_1.png",@window])
    cmd.use_cmd(:img,["../images/scenario/Scenario3_3_2.png",@window])
    cmd.use_cmd(:pic,[pseudo,"../grilles/scenario/canard",-1,600])
    cmd.use_cmd(:img,["../images/scenario/Scenario3_3_3.png",@window])
    cmd.use_cmd(:img,["../images/scenario/Scenario3_3_4.png",@window])
    cmd.use_cmd(:img,["../images/scenario/Scenario3_3_5.png",@window])
    cmd.use_cmd(:img,["../images/scenario/Scenario3_3_6.png",@window])
    cmd.use_cmd(:img,["../images/scenario/Scenario3_3_7.png",@window])
    cmd.use_cmd(:img,["../images/scenario/Scenario3_3_8.png",@window])
    cmd.use_cmd(:img,["../images/scenario/Scenario3_3_9.png",@window])
    cmd.use_cmd(:img,["../images/scenario/Scenario3_3_10.png",@window])
    cmd.use_cmd(:img,["../images/scenario/Scenario3_3_11.png",@window])
    cmd.use_cmd(:img,["../images/scenario/Scenario3_3_12.png",@window])
    cmd.use_cmd(:img,["../images/scenario/Scenario3_3_13.png",@window])
    cmd.use_cmd(:img,["../images/scenario/Scenario3_3_14.png",@window])



  end

end
