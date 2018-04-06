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
    if !img[2]

      if @window.child.children[0].child != nil
        @window.child.children[0].remove(@window.child.children[0].child)
      end
      @window.child.children[0].child = (Gtk::Image.new(:file =>img[0]))
      @window.child.children[0].child.show_all

      @window.child.children[0].signal_connect("button_press_event"){
          print "clicked\n"
          @window.hide
          Gtk.main_quit
      }

      @window.show_all
      Gtk.main

  else
    Gtk.main_quit
  end
  end
  ##
  # On detruit la fenetre

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

    if !pic[4]
       Gui.new(2,0,pic[0],pic[1],pic[2],pic[3],nil,nil,nil)
      
      @window.hide

    end
    Gtk.main_quit

  end

end
