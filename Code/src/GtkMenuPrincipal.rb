begin
  require 'rubygems'
 rescue LoadError
end
require 'gtk3'
load "GtkMap.rb"

class MenuPrincipal

  def initialize(game)
		@jeu=game

    puts("Creation fenetre Menu Principal")

    #Gtk.init

    #Création de la fenêtre
    @window = Gtk::Window.new("PiCross")
		@window.override_background_color(:normal,Gdk::RGBA.new(0,0,0,0))
    @window.set_size_request(400, 400)
    @window.resizable=FALSE
    @window.set_window_position(:center_always)

    @provider = Gtk::CssProvider.new
    @window.border_width=3

    @window.signal_connect('destroy') {onDestroy}

    #Création d'une VBox
    vb = Gtk::Box.new(:vertical, 5)
		vb.set_homogeneous(false)

		#Création d'un Label
		message = "Bonjour #{@jeu.pseudo}"
		messageBienvenue = Gtk::Label.new(message)
		vb.pack_start(messageBienvenue)

    #Création de la HBox1
    hb1 = Gtk::Box.new(:horizontal, 5)
    #Création du boutton JOUER
    bJouer = Gtk::Button.new(:label => "JOUER", :use_underline => nil, :stock_id => nil)
    bJouer.signal_connect "clicked" do
      @window.hide
      Gui.new("../grilles/Test2x2",1,0)
      @window.show_all

    end
    hb1.pack_start(bJouer, :expand => true, :fill => true)

    #Création du boutton SCOREBOARD
    bScoreboard = Gtk::Button.new(:label => "SCOREBOARD", :use_underline => nil, :stock_id => nil)
    hb1.pack_start(bScoreboard, :expand=> true, :fill => true)
    vb.pack_start(hb1, :expand => true, :fill => true)

    #Création de la HBox2
    hb2 = Gtk::Box.new(:horizontal, 5)
    #Création du boutton CREDITS
    bCredits = Gtk::Button.new(:label => "CREDITS", :use_underline => nil, :stock_id => nil)
    hb2.pack_start(bCredits, :expand => true, :fill => true)

    #Création du boutton QUITTER
    bQuitter = Gtk::Button.new(:label => "QUITTER", :use_underline => nil, :stock_id => nil)
    bQuitter.signal_connect "clicked" do
      onDestroy()
    end
    hb2.pack_start(bQuitter, :expand => true, :fill => true, :padding => 0)

    vb.pack_start(hb2, :expand => true, :fill => true, :padding => 0)

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
