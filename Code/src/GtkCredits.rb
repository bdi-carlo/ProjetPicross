begin
  require 'rubygems'
 rescue LoadError
end
require 'gtk3'

class Credits

  def initialize

    puts("Creation de la fenetre")

    #Création de la fenetre
    @window = Gtk::Window.new("Credits")
    @window.set_size_request(970, 700)
    @window.resizable=FALSE
    @window.set_window_position(:center_always)

    @provider = Gtk::CssProvider.new
    @window.border_width=10

    @window.signal_connect('destroy') {onDestroy}


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
