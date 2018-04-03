begin
  require 'rubygems'
 rescue LoadError
end
require 'gtk3'

class Menu

	def initialize(pseudo)
		@pseudo = pseudo
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
    puts "destroy menu"
		#Quit 'propre'
		@window.destroy
		Gtk.main_quit
	end

end
