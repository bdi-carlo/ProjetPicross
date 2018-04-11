begin
  require 'rubygems'
 rescue LoadError
end
require 'gtk3'

load "CursorPointer.rb"
load "CursorDefault.rb"
##
# Classe qui permet de créer une fenêtre
class Menu

	@@init = false

	def initialize(pseudo)
		if @@init == false
			Gtk.init
			@@init = true
		end
    @os = RbConfig::CONFIG['host_os']
		@pseudo = pseudo
		@cursorPointer = CursorPointer.getInstance()
		@cursorDefault = CursorDefault.getInstance()
	end
  ##
  # Crée la fenêtre de menu de base
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

	##
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
