begin
  require 'rubygems'
 rescue LoadError
end
require 'gtk3'
load "Jeu.rb"
load "GtkMenuPrincipal.rb"

class GtkScoreboard

  def initialize(game)
    @jeu=game

    puts("Creation fenetre Main")

    Gtk.init

    #Création de la fenêtre
    @window = Gtk::Window.new("PiCross")
    @window.set_size_request(300, 300)
    @window.resizable=FALSE
    @window.set_window_position(:center_always)

    @provider = Gtk::CssProvider.new
    @window.border_width=3

    @window.signal_connect('destroy') {onDestroy}

    #Création d'une vBox
    vb = Gtk::Box.new(:vertical, 10)
		vb.set_homogeneous(false)

    #Création du logo
    logo = Gtk::Image.new :file => '../images/logo.png'
    vb.pack_start(logo)

    #Création de la boite d'entrée du pseudo dans un hBox
    hb = Gtk::Box.new(:horizontal, 40)
    button = Gtk::Button.new(:label => "  Facile  ", :use_underline => nil, :stock_id => nil)
    button.signal_connect "clicked" do
      @jeu.difficulte=("EASY")
      @window.hide
      GtkScoreBoarddiff.new(@jeu)
      onDestroy()
    end
    hb.pack_start(button, :expand=> false, :fill => false)
    halign = Gtk::Alignment.new 0.5,0,0,0
    halign.add hb
    vb.pack_start(halign, :expand=> false, :fill => false)

      hb2 = Gtk::Box.new(:horizontal, 40)
    button2 = Gtk::Button.new(:label => " Moyen ", :use_underline => nil, :stock_id => nil)
    button.signal_connect "clicked" do
      @jeu.difficulte=("NORMAL")
      @window.hide
      GtkScoreBoarddiff.new(@jeu)
      onDestroy()
    end
    hb2.pack_start(button2, :expand=> false, :fill => false)
    halign2 =  Gtk::Alignment.new 0.5,0,0,0
    halign2.add hb2
    vb.pack_start(halign2, :expand=> false, :fill => false)

      hb3 = Gtk::Box.new(:horizontal, 40)
      button3 = Gtk::Button.new(:label => "Difficile", :use_underline => nil, :stock_id => nil)
      button.signal_connect "clicked" do
      @jeu.difficulte=("HARD")
      @window.hide
      GtkScoreBoarddiff.new(@jeu)
      onDestroy()
    end
      hb3.pack_start(button3, :expand=> false, :fill => false)
      halign3 = Gtk::Alignment.new 0.5,0,0,0
      halign3.add hb3
     vb.pack_start(halign3, :expand=> false, :fill => false)


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

GtkScoreboard.new(Jeu.new)
