begin
  require 'rubygems'
 rescue LoadError
end
require 'gtk3'
load "GtkMap.rb"
# Recepteur du scénario, toutes les commandes arrivent içi
class ScenarioUI

  def initialize()
  end
  ##
  # Affiche une image dans la fenetre en parametre
  #
  # Param: Tableau contenant en 0 le lien d'un image et en 1 l'instance de la fenetre
  def execImage(img)
    @window = img[1]

    @window.set_size_request(970, 700)
    @window.resizable=FALSE
    @window.set_window_position(:center_always)
    # On set le titre
    @window.set_title("Picross")
    @window.border_width=10
    @window.signal_connect('destroy') {onDestroy}
    if @window.child.child != nil
      @window.child.remove(@window.child.child)
    end
    @window.child.child = (Gtk::Image.new(:file =>img[0]))
    @window.child.show_all

    @window.child.signal_connect("button_press_event"){
        print "clicked\n"
        @window.hide
        Gtk.main_quit
    }

    @window.show_all
    Gtk.main
  end
  ##
  # On detruit la fenetre
  def onDestroy
    #Quit 'propre'
    Gtk.main_quit
  end
  ##
  # Execute un Picross
  #
  # Param : Tableau contenant
  # * pseudo
  # * Chemin map
  # * incrément
  # * départ du timer
  # * map
  # * hypothèse
  # * nbHypo
  def execPic(pic)

    Gui.new(0,pic[0],pic[1],pic[2],pic[3],nil,nil,nil)
    Gtk.main_quit
  end

end
