begin
  require 'rubygems'
 rescue LoadError
end
require 'gtk3'
load "GtkMap.rb"

class MenuPrincipal

  def initialize(game)
		@jeu=game

    puts("Creation de la fenetre")

    #Gtk.init

    #Création de la fenêtre
    @window = Gtk::Window.new("PiCross")
    @window.set_size_request(400, 400)
    @window.resizable=FALSE
    @window.set_window_position(:center_always)

    @provider = Gtk::CssProvider.new
    @window.border_width=3

    @window.signal_connect('destroy') {onDestroy}

    #Création d'une VBox
    vb = Gtk::VBox.new(false, 5)
		vb.set_homogeneous(false)

		#Création d'un Label
		message = "Bonjour #{@jeu.pseudo}"
		messageBienvenue = Gtk::Label.new(message)
		vb.pack_start(messageBienvenue)

    #Création de la HBox1
    hb1 = Gtk::HBox.new(true, 5)
    #Création du boutton JOUER
    bJouer = Gtk::Button.new "JOUER"
    bJouer.signal_connect "clicked" do
      @window.hide_all
      Gui.new("../grilles/Test2x2",1,0)
      @window.show_all

    end
		bJouer.expand=true
    hb1.pack_start(bJouer,true,true)

    #Création du boutton SCOREBOARD
    bScoreboard = Gtk::Button.new "SCOREBOARD"
		bScoreboard.expand=true
    hb1.pack_start(bScoreboard,true,true)
    vb.pack_start(hb1,true,true)

    #Création de la HBox2
    hb2 = Gtk::HBox.new(true, 5)
    #Création du boutton CREDITS
    bCredits = Gtk::Button.new "CREDITS"
		bCredits.expand=true
    hb2.pack_start(bCredits,true,true)

    #Création du boutton QUITTER
    bQuitter = Gtk::Button.new "QUITTER"
    bQuitter.signal_connect "clicked" do
      onDestroy()
    end
		bQuitter.expand=true
		#bQuitter.fill(true)
    hb2.pack_start(bQuitter,true,true)

    vb.pack_start(hb2,true,true)

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
