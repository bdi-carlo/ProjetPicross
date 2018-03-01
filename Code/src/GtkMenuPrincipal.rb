begin
  require 'rubygems'
 rescue LoadError
end
require 'gtk3'
load "GtkMap.rb"

class MenuPrincipal

  def initialize

    puts("Creation de la fenetre")

    #Gtk.init

    #Création de la fenêtre
    @window = Gtk::Window.new("PiCross")
    @window.set_size_request(970, 700)
    @window.resizable=FALSE
    @window.set_window_position(:center_always)

    @provider = Gtk::CssProvider.new
    @window.border_width=10

    @window.signal_connect('destroy') {onDestroy}

    #Création d'une VBox
    vb = Gtk::VBox.new(true, 6)

    #Création de la HBox1
    hb1 = Gtk::HBox.new(false, 6)
    #Création du boutton JOUER
    bJouer = Gtk::Button.new "JOUER"
    bJouer.signal_connect "clicked" do
      @window.hide_all
      Gui.new("../grilles/Scenario/Bateau",1,0)
      @window.show_all

    end
    hb1.pack_start(bJouer)

    #Création du boutton SCOREBOARD
    bScoreboard = Gtk::Button.new "SCOREBOARD"
    hb1.pack_start(bScoreboard)
    vb.pack_start(hb1)

    #Création de la HBox2
    hb2 = Gtk::HBox.new(false, 6)
    #Création du boutton CREDITS
    bCredits = Gtk::Button.new "CREDITS"
    hb2.pack_start(bCredits)

    #Création du boutton QUITTER
    bQuitter = Gtk::Button.new "QUITTER"
    bQuitter.signal_connect "clicked" do
      onDestroy()
    end
    hb2.pack_start(bQuitter)

    vb.pack_start(hb2)

    @window.add(vb)
    @window.show_all

    Gtk.main

  end

  ##
  # Callback de la fermeture de l'appli
  def onDestroy
    puts "Fin de l'application"
    #Quit 'propre'
    Gtk.main_quit
  end

end
