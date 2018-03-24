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
    vb = Gtk::Box.new(:vertical, 30)
		vb.set_homogeneous(false)

    #Création du logo
    logo = Gtk::Image.new :file => '../images/logo.png'
    vb.pack_start(logo)

    #Création de la boite d'entrée du pseudo dans un hBox
    hb = Gtk::Box.new(:horizontal, 6)
    hb.pack_start(Gtk::Label.new('Pseudo'), :expand => false, :fill => true, :padding => 6)
    nom = Gtk::Entry.new
    #nom.set_text "Entrer votre pseudo"
    hb.pack_start(nom, :expand => true, :fill => true)
    vb.pack_start(hb)

    #Création du bouton pour confirmer notre Pseudo
    button = Gtk::Button.new(:label => "CONTINUER", :use_underline => nil, :stock_id => nil)
    button.signal_connect "clicked" do
      if(nom.text == "")
				dialogBox("Veuillez rentrer un pseudo avant de jouer!")
    	else
        @jeu.pseudo = nom.text
        puts "Pseudo: " + @jeu.pseudo
        @window.hide
        MenuPrincipal.new(@jeu)
        onDestroy()
      end
    end
    vb.pack_start(button)

    @window.add(vb)

    @window.show_all

    Gtk.main

  end

	#Affiche une boite de dialogue avec un message
	def dialogBox( message )
		dialog = Gtk::Dialog.new("Alerte",
                             $main_application_window,
                             Gtk::Dialog::DESTROY_WITH_PARENT,
                             [ Gtk::Stock::OK, Gtk::Dialog::RESPONSE_NONE ])
		dialog.set_window_position(:center_always)

    # Ensure that the dialog box is destroyed when the user responds.
    dialog.signal_connect('response') { dialog.destroy }

    # Add the message in a label, and show everything we've added to the dialog.
    dialog.vbox.add(Gtk::Label.new( "\n" + message + "\n" ))
    dialog.show_all
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
