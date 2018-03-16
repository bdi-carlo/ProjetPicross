begin
  require 'rubygems'
 rescue LoadError
end
require 'gtk3'
load "GtkMap.rb"

class MenuJouer

  def initialize()

    puts("Creation fenetre Jouer")

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

    #Création de la HBox1
    hb1 = Gtk::Box.new(:horizontal, 5)
    #Création du boutton Aventure
    bAventure = Gtk::Button.new(:label => "Aventure", :use_underline => nil, :stock_id => nil)
   # bJouer.signal_connect "clicked" do
    	#@window.hide
    	#Gui.new("../grilles/10x10/Neuf",1,0)
    	#@window.show_all
       # end
    hb1.pack_start(bAventure, :expand => true, :fill => true)

    #Création du boutton Competition
    bCompetition = Gtk::Button.new(:label => "Competition", :use_underline => nil, :stock_id => nil)
    hb1.pack_start(bCompetition, :expand=> true, :fill => true)
    vb.pack_start(hb1, :expand => true, :fill => true)

    #Création de la HBox2
    hb2 = Gtk::Box.new(:horizontal, 5)
    #Création du boutton Normal
    bNormal = Gtk::Button.new(:label => "Normal", :use_underline => nil, :stock_id => nil)
    hb2.pack_start(bNormal, :expand => true, :fill => true)
    bNormal.signal_connect "clicked" do
      @window.destroy
      Gui.new("../grilles/10x10/Neuf",1,0)
      onDestroy()
    end

    #Création du boutton Didacticiel
    bDidacticiel = Gtk::Button.new(:label => "Didacticiel", :use_underline => nil, :stock_id => nil)
    hb2.pack_start(bDidacticiel, :expand => true, :fill => true, :padding => 0)

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
