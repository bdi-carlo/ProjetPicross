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
    @window = Gtk::Window.new
    @window.set_size_request(970, 700)
    @window.resizable=FALSE
    @window.set_window_position(:center_always)
    # On set le titre
    @window.set_title("Picross")
    @window.border_width=10
    @window.signal_connect('destroy') {onDestroy}
    event=Gtk::EventBox.new()
    event.child = (Gtk::Image.new(:file =>img))
    event.show_all

    event.signal_connect("button_press_event"){
        print "clicked\n"
        @window.destroy
        Gtk.main_quit
    }
    @window.add(event)
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
  end

end
