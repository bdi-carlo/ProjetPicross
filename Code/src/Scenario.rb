begin
  require 'rubygems'
 rescue LoadError
end
require 'gtk3'
load "GtkMap.rb"
class ScenarioUI

  def initialize()

  end
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
  def onDestroy
    puts "Fermeture picross"
    #Quit 'propre'
    Gtk.main_quit
  end
  def execPic(pic)

    Gui.new(0,pic[0],pic[1],pic[2],pic[3],nil,nil,nil)
    Gtk.main_quit
  end

end
