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
    fichier = File.open("../scoreboard/Save_scenar")
    allsave = []
    @destroy_everything = false
    @start = 0
    fichier.each_line{ |ligne|
      allsave.push(ligne.to_s)
    }
    for fic in allsave do
      if fic.split("-")[0]==pseudo
        @start = fic.split("-")[1].to_i
      end
    end
    scenar = ScenarioUI.new

    @window = Gtk::Window.new()
    event=Gtk::EventBox.new()
    vb = Gtk::Box.new(:horizontal)
    iQuitter = Gtk::Image.new(:file => "../images/boutons/quitter.png")
    @bQuitter = Gtk::EventBox.new.add(iQuitter)
    @bQuitter.signal_connect("enter_notify_event") do
      @bQuitter.remove(@bQuitter.child)
      @bQuitter.child = Gtk::Image.new(:file => "../images/boutons/quitterOver.png")

      @bQuitter.show_all
    end
    @bQuitter.signal_connect("leave_notify_event")do |button|
      @bQuitter.remove(@bQuitter.child)
      @bQuitter.child = Gtk::Image.new(:file => "../images/boutons/quitter.png")

      @bQuitter.show_all
    end
    @bQuitter.signal_connect("button_press_event") do
      onDestroy()
    end
    vb.add(event)
    vb.add(@bQuitter)
    @window.add(vb)
    @pseudo = pseudo
    @window.set_size_request(970, 700)
    @window.resizable=FALSE
    @window.set_window_position(:center_always)
    @window.set_title("Picross")
    @window.border_width=10
    @window.signal_connect('destroy') {onDestroy}
    cmd = ScenarioCmd.new(scenar)
    if @start<11
      if @start<10
        if @start<9
          if @start<8
            if @start<7
              if @start<6
                if @start<5
                  if @start<4
                    if @start<3
                      if @start<2
                        if @start<1
                          # :img pour une image :pic pour un picross
                          cmd.use_cmd(:img,["../images/scenario/Scenario1_1_1.png",@window,@destroy_everything])
                          cmd.use_cmd(:img,["../images/scenario/Scenario1_1_2.png",@window,@destroy_everything])
                          cmd.use_cmd(:pic,[pseudo,"../grilles/scenario/Pont",1,0,@destroy_everything])
                          @start = 1
                        end
                        cmd.use_cmd(:img,["../images/scenario/Scenario1_1_3.png",@window,@destroy_everything])
                        cmd.use_cmd(:img,["../images/scenario/Scenario1_2_1.png",@window,@destroy_everything])
                        cmd.use_cmd(:pic,[pseudo,"../grilles/scenario/Echelle",1,0,@destroy_everything])
                        @start = 2
                      end
                      cmd.use_cmd(:img,["../images/scenario/Scenario1_2_2.png",@window,@destroy_everything])
                      cmd.use_cmd(:img,["../images/scenario/Scenario1_2_3.png",@window,@destroy_everything])
                      cmd.use_cmd(:img,["../images/scenario/Scenario1_3_1.png",@window,@destroy_everything])
                      cmd.use_cmd(:img,["../images/scenario/Scenario1_3_2.png",@window,@destroy_everything])
                      cmd.use_cmd(:img,["../images/scenario/Scenario1_3_3.png",@window,@destroy_everything])
                      cmd.use_cmd(:img,["../images/scenario/Scenario1_3_4.png",@window,@destroy_everything])
                      cmd.use_cmd(:pic,[pseudo,"../grilles/scenario/cle",1,0,@destroy_everything])
                      @start = 3
                    end
                    cmd.use_cmd(:img,["../images/scenario/Scenario1_4_1.png",@window,@destroy_everything])
                    cmd.use_cmd(:img,["../images/scenario/Scenario1_4_2.png",@window,@destroy_everything])
                    cmd.use_cmd(:pic,[pseudo,"../grilles/scenario/Bateau",-1,800,@destroy_everything])
                    @start = 4
                  end
                  cmd.use_cmd(:img,["../images/scenario/Scenario2_1_1.png",@window,@destroy_everything])
                  cmd.use_cmd(:img,["../images/scenario/Scenario2_1_2.png",@window,@destroy_everything])
                  cmd.use_cmd(:pic,[pseudo,"../grilles/scenario/doubleFish",1,0,@destroy_everything])
                  @start = 5
                end
                cmd.use_cmd(:img,["../images/scenario/Scenario2_1_3.png",@window,@destroy_everything])
                cmd.use_cmd(:img,["../images/scenario/Scenario2_1_4.png",@window,@destroy_everything])
                cmd.use_cmd(:img,["../images/scenario/Scenario2_2_1.png",@window,@destroy_everything])
                cmd.use_cmd(:img,["../images/scenario/Scenario2_2_2.png",@window,@destroy_everything])
                cmd.use_cmd(:pic,[pseudo,"../grilles/scenario/pirateFlag",1,0,@destroy_everything])
                @start = 6
              end
              cmd.use_cmd(:img,["../images/scenario/Scenario2_3_1.png",@window,@destroy_everything])
              cmd.use_cmd(:img,["../images/scenario/Scenario2_3_2.png",@window,@destroy_everything])
              cmd.use_cmd(:img,["../images/scenario/Scenario2_3_3.png",@window,@destroy_everything])
              cmd.use_cmd(:pic,[pseudo,"../grilles/scenario/anchor",1,0,@destroy_everything])
              @start = 7
            end
            cmd.use_cmd(:img,["../images/scenario/Scenario2_4_1.png",@window,@destroy_everything])
            cmd.use_cmd(:img,["../images/scenario/Scenario2_4_2.png",@window,@destroy_everything])
            cmd.use_cmd(:pic,[pseudo,"../grilles/scenario/Qrvent",-1,800,@destroy_everything])
            @start = 8
          end
          cmd.use_cmd(:img,["../images/scenario/Scenario2_4_3.png",@window,@destroy_everything])
          cmd.use_cmd(:img,["../images/scenario/Scenario3_1_1.png",@window,@destroy_everything])
          cmd.use_cmd(:img,["../images/scenario/Scenario3_1_2.png",@window,@destroy_everything])
          cmd.use_cmd(:img,["../images/scenario/Scenario3_1_3.png",@window,@destroy_everything])
          cmd.use_cmd(:pic,[pseudo,"../grilles/scenario/labyrinthe",1,0,@destroy_everything])
          @start = 9
        end
        cmd.use_cmd(:img,["../images/scenario/Scenario3_2_1.png",@window,@destroy_everything])
        cmd.use_cmd(:pic,[pseudo,"../grilles/scenario/castle",1,0,@destroy_everything])
        @start = 10
      end
      cmd.use_cmd(:img,["../images/scenario/Scenario3_2_2.png",@window,@destroy_everything])
      cmd.use_cmd(:img,["../images/scenario/Scenario3_3_1.png",@window,@destroy_everything])
      cmd.use_cmd(:img,["../images/scenario/Scenario3_3_2.png",@window,@destroy_everything])
      cmd.use_cmd(:pic,[pseudo,"../grilles/scenario/canard",-1,600,@destroy_everything])
      @start=11
    end
    cmd.use_cmd(:img,["../images/scenario/Scenario3_3_3.png",@window,@destroy_everything])
    cmd.use_cmd(:img,["../images/scenario/Scenario3_3_4.png",@window,@destroy_everything])
    cmd.use_cmd(:img,["../images/scenario/Scenario3_3_5.png",@window,@destroy_everything])
    cmd.use_cmd(:img,["../images/scenario/Scenario3_3_6.png",@window,@destroy_everything])
    cmd.use_cmd(:img,["../images/scenario/Scenario3_3_7.png",@window,@destroy_everything])
    cmd.use_cmd(:img,["../images/scenario/Scenario3_3_8.png",@window,@destroy_everything])
    cmd.use_cmd(:img,["../images/scenario/Scenario3_3_9.png",@window,@destroy_everything])
    cmd.use_cmd(:img,["../images/scenario/Scenario3_3_10.png",@window,@destroy_everything])
    cmd.use_cmd(:img,["../images/scenario/Scenario3_3_11.png",@window,@destroy_everything])
    cmd.use_cmd(:img,["../images/scenario/Scenario3_3_12.png",@window,@destroy_everything])
    cmd.use_cmd(:img,["../images/scenario/Scenario3_3_13.png",@window,@destroy_everything])
    cmd.use_cmd(:img,["../images/scenario/Scenario3_3_14.png",@window,@destroy_everything])
    if !@destroy_everything
      viderSave()

      MenuPrincipal.new(@pseudo)
    end

  end
  def onDestroy()
    fichier = File.open("../scoreboard/Save_scenar","a")
    puts "QUIIIIIT"
    @window.hide
    fichier.puts("#{@pseudo}-#{@start}")
    fichier.close
    Gtk.main_quit
    @destroy_everything = true
    MenuPrincipal.new(@pseudo)
  end
  def viderSave()
    monFichier = File.open("../scoreboard/Save_scenar",)
		#Récupération des scores déjà exists
		allScores = []
		monFichier.each_line{ |ligne|
			allScores.push(ligne.to_s)
		}
		#Suppression de ce qu'il y a dedans
		monFichier = File.open("../scoreboard/Save_scenar", "a")
		File.truncate("../scoreboard/Save_scenar",0)
		#Réecriture de tous les scores triés dans le fichier
			# for line in allScores do
      #   if line.split('-')[0] == @pseudo
      #     allScores.remove(line)
      #   end
      # end

			allScores.delete_if{|line| line.split('-')[0] == @pseudo}.each{ |ligne|
				monFichier.write(ligne)
			}
		monFichier.close

  end
end
