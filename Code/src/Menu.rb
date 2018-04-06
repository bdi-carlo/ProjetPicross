begin
  require 'rubygems'
 rescue LoadError
end
require 'gtk3'

load "CursorPointer.rb"
load "CursorDefault.rb"

class Menu

	@@init = false

	def initialize(pseudo)
		if @@init == false
			Gtk.init
			@@init = true
		end
		@pseudo = pseudo
		@cursorPointer = CursorPointer.getInstance()
		@cursorDefault = CursorDefault.getInstance()
	end

	def creerWindow()
		#Création de la fenêtre
    @window = Gtk::Window.new("PiCross")
    #@window.set_size_request(300, 300)
    @window.resizable=FALSE
    @window.set_window_position(:center_always)

  	@window.signal_connect('destroy') {onDestroy}

		return @window
	end

	##
	# Callback de la fermeture de l'appli
	def onDestroy
    @window.hide
		#puts "Fermeture fenetre"
    #puts "destroy menu"
		#Quit 'propre'
		# @window.destroy JAMAIS SINON CA PLANTE
		Gtk.main_quit
	end

end
