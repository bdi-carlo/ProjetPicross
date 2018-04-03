begin
  require 'rubygems'
 rescue LoadError
end
require 'gtk3'
load "GtkMenuPrincipal.rb"

class Main < Menu

  def initialize(pseudo)
    super(pseudo)
		lancerFenetre()
  end

	def lancerFenetre()
		puts("Creation fenetre Main")

    Gtk.init

    @window = creerWindow()

		grid = Gtk::Grid.new
		hb = Gtk::Box.new(:horizontal, 10)
		vb = Gtk::Box.new(:vertical, 20)

		#Label de bordure gauche
		hb.add(Gtk::Label.new(""))

		#Label de bordure haut
		vb.add(Gtk::Label.new("\n\n\n\n\n\n\n\n\n\n\n\n"))

    #Création de la boite d'entrée du pseudo dans un hBox
    hbPseudo = Gtk::Box.new(:horizontal, 6)
    hbPseudo.pack_start(Gtk::Label.new.set_markup("<span foreground='white'>Pseudo</span>"), :expand => false, :fill => false, :padding => 6)
    nom = Gtk::Entry.new
    hbPseudo.add(nom, :expand => false, :fill => false)
		vb.add(hbPseudo)

    #Création du bouton pour confirmer notre Pseudo
    iButton = Gtk::Image.new(:file => "../images/boutons/jouer.png")
		@button = Gtk::EventBox.new.add(iButton)
		@button.signal_connect("enter_notify_event"){
			@button.remove(@button.child)
			@button.child = Gtk::Image.new(:file => "../images/boutons/jouerOver.png")
			@button.show_all
		}
		@button.signal_connect("leave_notify_event"){
			@button.remove(@button.child)
			@button.child = Gtk::Image.new(:file => "../images/boutons/jouer.png")
			@button.show_all
		}
    @button.signal_connect("button_press_event") do
      if(nom.text == "")
				dialogBox("Veuillez rentrer un pseudo avant de jouer!")
    	else
        @pseudo = nom.text
        puts "Pseudo: " + @pseudo
				onDestroy()
        MenuPrincipal.new(@pseudo)
      end
    end
		vb.add(@button)

		hb.add(vb)

		#Label d'espacement
		hb.add(Gtk::Label.new(" "))

    grid.attach(hb,0,0,1,1)

		#Wallpaper
		image = Gtk::Image.new(:file => "../images/wallpaper.jpg")
		grid.attach(image,0,0,1,1)

		@window.add(grid)

    @window.show_all

    Gtk.main
	end

	#Affiche une boite de dialogue avec un message
	def dialogBox( message )
		dialog = Gtk::Dialog.new("Alerte",
                             $main_application_window,
                             :destroy_with_parent,
                             [ Gtk::Stock::OK, :none ])
		dialog.set_window_position(:center_always)

    # Ensure that the dialog box is destroyed when the user responds.
    dialog.signal_connect('response') { dialog.destroy }

    # Add the message in a label, and show everything we've added to the dialog.
    dialog.child.add(Gtk::Label.new( "\n" + message + "\n" ))
    dialog.show_all
	end

end

Main.new("")
