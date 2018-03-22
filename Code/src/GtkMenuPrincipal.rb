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
		@window.override_background_color(:normal,Gdk::RGBA.new(255,0,0,0.9))
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
    image = Gtk::Image.new(:file => "Jouer.png")
    bJouer = Gtk::EventBox.new.add(image)
    bJouer.signal_connect("button_press_event") do
        @window.hide
        MenuJouer.new()
        @window.show_all
    end


    bJouer.signal_connect("enter_notify_event"){
      onEnterJouer(bJouer)
    }
    bJouer.signal_connect("leave_notify_event"){
      onLeaveJouer(bJouer)
    }
    vb.pack_start(bJouer, :expand => true, :fill => true)

    #Création du boutton SCORE
    bScore = Gtk::Button.new(:label => "Scoreboard", :use_underline => nil, :stock_id => nil)
    vb.pack_start(bScore, :expand=> true, :fill => true)

    #Création du boutton CREDITS
    bCredits = Gtk::Button.new(:label => "Credits", :use_underline => nil, :stock_id => nil)
    vb.pack_start(bCredits, :expand => true, :fill => true)

    #Création du boutton QUITTER
    bQuitter = Gtk::Button.new(:label => "Quitter", :use_underline => nil, :stock_id => nil)
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

  def onEnterJouer(button)
    button.remove(button.child)
    button.child = Gtk::Image.new(:file => "JouerTransparent.png")
    button.show_all
  end

   def onLeaveJouer(button)
    button.remove(button.child)
    button.child = Gtk::Image.new(:file => "Jouer.png")
    button.show_all
  end

end
