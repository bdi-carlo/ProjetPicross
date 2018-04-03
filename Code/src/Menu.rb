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

	def appliqueProvider(window)
		@provider = Gtk::CssProvider.new
		@provider.load :data => '.window{
			color: #FFFFFF;
		}'
		apply_style(window, @provider)
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

	def apply_style(widget, provider)
	    style_context = widget.style_context
	    style_context.add_provider(provider, Gtk::StyleProvider::PRIORITY_USER)
	    return unless widget.respond_to?(:children)
	    widget.children.each do |child|
	      apply_style(child, provider)
			end
	end

end
