begin
  require 'rubygems'
 rescue LoadError
end
require 'gtk3'
require "date"

load "GtkMap.rb"

class MenuCharger

  def initialize(game)
		@jeu = game

    puts("Creation fenetre Charger")

		#Création de la fenêtre
		@window = Gtk::Window.new("Picross")
		#@window.set_size_request(300, 300)
		@window.resizable=FALSE
		@window.set_window_position(:center_always)

		@window.signal_connect('destroy') {onDestroy}

		grid = Gtk::Grid.new
		hb = Gtk::Box.new(:horizontal, 10)
		vb = Gtk::Box.new(:vertical, 20)

		#Label de bordure
		hb.add(Gtk::Label.new(""))

		#Label de bordure
		vb.add(Gtk::Label.new("\n"))

		#Label du pseudo
		lPseudo = Gtk::Label.new
		lPseudo.set_markup("<big><i><big><b><span foreground='white'>#{@jeu.pseudo}</span></b></big></i></big>")
		#lPseudo.wrap = true
		vb.add(lPseudo)

		#Label d'espacement
		vb.add(Gtk::Label.new("\n\n\n"))

		#Création du bouton JOUER
		iJouer = Gtk::Image.new(:file => "../images/boutons/jouer.png")
		@bJouer = Gtk::EventBox.new.add(iJouer)
		@bJouer.signal_connect("enter_notify_event"){

		}
		@bJouer.signal_connect("leave_notify_event"){

		}
		@bJouer.signal_connect("button_press_event") do
			charger("../sauvegardes/test_Neuf")
		end
		vb.add(@bJouer)

		hb.add(vb)

		#Label d'espacement
		hb.add(Gtk::Label.new(""))

		grid.attach(hb,0,0,1,1)

		image = Gtk::Image.new(:file => "../images/wallpaper.jpg")
		grid.attach(image,0,0,1,1)

		@window.add(grid)

		@window.show_all

		Gtk.main
	end

	##
	# Charge la partie
	#
	# Param : identificateurs d'une partie
	# Retour : La grille chargée
	def charger(nomSave)
		# Deserialisation et retourne la grille
		obj = Marshal.load(File.open("../sauvegardes/"+nomSave))
		return obj
	end

	##
	# Callback de la fermeture de l'appli
	def onDestroy
		puts "Fin de l'application"
		#Quit 'propre'
		Gtk.main_quit
	end

end
