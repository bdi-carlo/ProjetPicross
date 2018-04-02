begin
  require 'rubygems'
 rescue LoadError
end
require 'gtk3'

class Menu

	def initialize(game)
		@jeu = game
	end

	def lancerFenetre()

	end

	def creerWindow()
		#Création de la fenêtre
    window = Gtk::Window.new("PiCross")
    #@window.set_size_request(300, 300)
    window.resizable=FALSE
    window.set_window_position(:center_always)

  	window.signal_connect('destroy') {onDestroy}

		return window
	end

	##
	# Callback de la fermeture de l'appli
	def onDestroy
		puts "Fermeture fenetre"
		#Quit 'propre'
		Gtk.main_quit
	end

end
