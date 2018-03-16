begin
  require 'rubygems'
 rescue LoadError
end
require 'gtk3'
load "GtkMap.rb"
load "GtkMenuJouer.rb"

class MenuPrincipal

  def initialize(game)
		@jeu=game

    puts("Creation fenetre Menu Principal")

    #Gtk.init

    #Création de la fenêtre
    @window = Gtk::Window.new("PiCross")
		@window.override_background_color(:normal,Gdk::RGBA.new(0,0,0,0))
    @window.set_size_request(300, 300)
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

    #Création du boutton JOUER
    bJouer = Gtk::Button.new(:label => "JOUER", :use_underline => nil, :stock_id => nil)
    bJouer.signal_connect "clicked" do
     @window.hide
     MenuJouer.new()
     @window.show_all
    end
    vb.pack_start(bJouer, :expand => true, :fill => true)

    #Création du boutton SCORE
    bScore = Gtk::Button.new(:label => "SCOREBOARD", :use_underline => nil, :stock_id => nil)
    vb.pack_start(bScore, :expand=> true, :fill => true)

    #Création du boutton CREDITS
    bCredits = Gtk::Button.new(:label => "CREDITS", :use_underline => nil, :stock_id => nil)
    vb.pack_start(bCredits, :expand => true, :fill => true)

    #Création du boutton QUITTER
    bQuitter = Gtk::Button.new(:label => "QUITTER", :use_underline => nil, :stock_id => nil)
    bQuitter.signal_connect "clicked" do
      onDestroy()
    end
    vb.pack_start(bQuitter, :expand => true, :fill => true, :padding => 0)

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
