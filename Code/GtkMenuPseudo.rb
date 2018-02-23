begin
  require 'rubygems'
 rescue LoadError
end
require 'gtk3'

class MenuPseudo

  def initialize

    puts("Creation de la fenetre")

    Gtk.init

    #Création de la fenêtre
    @window = Gtk::Window.new("PiCross")
    @window.set_size_request(970, 700)
    @window.resizable=FALSE
    @window.set_window_position(:center_always)

    @provider = Gtk::CssProvider.new
    @window.border_width=10

    @window.signal_connect('destroy') {onDestroy}

    #Création de la boite d'entrée du pseudo dans un hBox
    hb = Gtk::HBox.new(false, 6)
    hb.pack_start(Gtk::Label.new('Pseudo'), false, true, 6)
    nom = Gtk::Entry.new
    nom.set_text "Entrer votre pseudo"
    hb.pack_start(nom, true, true)

    @window.add(hb)

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

MenuPseudo.new
