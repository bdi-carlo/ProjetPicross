begin
  require 'rubygems'
 rescue LoadError
end
require 'gtk3'
load "Jeu.rb"
load "GtkMenuPrincipal.rb"

class Main

  def initialize(game)
    @jeu=game

    puts("Creation de la fenetre")

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
    vb = Gtk::VBox.new(true, 30)
		vb.set_homogeneous(false)

    #Création du logo
    logo = Gtk::Image.new :file => '../images/logo.png'
    vb.pack_start(logo)

    #Création de la boite d'entrée du pseudo dans un hBox
    hb = Gtk::HBox.new(false, 6)
    hb.pack_start(Gtk::Label.new('Pseudo'), false, true, 6)
    nom = Gtk::Entry.new
    nom.set_text "Entrer votre pseudo"
    hb.pack_start(nom, true, true)
    vb.pack_start(hb)

    #Création du bouton pour confirmer notre Pseudo
    button = Gtk::Button.new "CONTINUER"
    button.signal_connect "clicked" do
    	@jeu.setPseudo(nom.text)
      puts @jeu.pseudo
      @window.hide_all
      MenuPrincipal.new
      onDestroy()
    end
    vb.pack_start(button)

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

Main.new( Jeu.new )
