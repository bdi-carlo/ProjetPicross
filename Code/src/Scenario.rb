begin
  require 'rubygems'
 rescue LoadError
end
require 'gtk3'
load ("GtkMap.rb")
class ScenarioUI

  @@currentArea = 0  #La zone du lvl
  @@currentFrame = 0  #Position dans le Tableau
  @@currentLvl = 0  #Position du Tableau dans la banque d'image
  def initialize()

    @window = Gtk::Window.new.override_background_color(:normal  , Gdk::RGBA.new())
    @window.set_size_request(800, 400)
    @window.resizable=FALSE
    @window.set_window_position( Gtk::WindowPosition::CENTER_ALWAYS)
    # On set le titre
    @window.set_title("PIcross")

    @screenSplit = Gtk::Box.new(:vertical)

    @imageBank = Array.new(4) {Array.new}

    lvl1 = Array.new
    lvl1<<"./Scenario1_1_1.png" << "./Scenario1_1_2.png" << "./Scenario1_1_3.png"
    @imageBank[0].push(lvl1)
    lvl2 = Array.new
    lvl2<<"./Scenario1_2_1.png" << "./Scenario1_2_2.png" << "./Scenario1_2_3.png"
    @imageBank[0].push(lvl2)
    lvl3 = Array.new
    lvl3<<"./Scenario1_3_1.png" << "./Scenario1_3_2.png" << "./Scenario1_3_3.png" << "./Scenario1_3_4.png"
    @imageBank[0].push(lvl3)

    @image = Gtk::Image.new(:file => @imageBank[@@currentArea][@@currentLvl][@@currentFrame])
    @buttonImage = Gtk::Button.new()
    @buttonImage.set_image(@image)
    @screenSplit.add(@buttonImage)
    @buttonSuivant = Gtk::Button.new("Suivant")
    @buttonSuivant.signal_connect("clicked"){
      suivant()
    }

    @screenSplit.add(@buttonSuivant)
    @window.add(@screenSplit)
    @window.signal_connect('destroy') {onDestroy}
    @window.show_all
    Gtk.main
  end

  def suivant()


    if (@@currentArea == 0 && @@currentLvl == 0 && @@currentFrame == 1)

      @@currentFrame = 2
      @window.hide_all()
      map = Gui.new("./scenario_pont",1,0)
      print "#{@imageBank[@@currentArea][@@currentLvl][@@currentFrame]}\n"
      @image = Gtk::Image.new(:file => @imageBank[@@currentArea][@@currentLvl][@@currentFrame])
      @buttonImage.set_image(@image)
      @window.show_all()

    elsif (@@currentArea == 0 && @@currentLvl == 1 && @@currentFrame == 0)
        @@currentFrame = 1
       map = Gui.new("./scenario_echelle",1,0)
       print "#{@imageBank[@@currentArea][@@currentLvl][@@currentFrame]}\n"
       @image = Gtk::Image.new(:file => @imageBank[@@currentArea][@@currentLvl][@@currentFrame])
       @buttonImage.set_image(@image)

    elsif (@@currentArea == 0 && @@currentLvl == 2 && @@currentFrame == 2)
        @@currentFrame = 3
        print "#{@imageBank[@@currentArea][@@currentLvl][@@currentFrame]}\n"
        @image = Gtk::Image.new(:file => @imageBank[@@currentArea][@@currentLvl][@@currentFrame])
        @buttonImage.set_image(@image)

    elsif (@@currentArea == 0 && @@currentLvl == 2 && @@currentFrame == 3)
        @@currentFrame = 0
        @@currentLvl = 3
        map = Gui.new("./scenario_QRvent")
        print "#{@imageBank[@@currentArea][@@currentLvl][@@currentFrame]}\n"
        @image = Gtk::Image.new(:file => @imageBank[@@currentArea][@@currentLvl][@@currentFrame])
        @buttonImage.set_image(@image)
    else
      @@currentFrame +=1
      if (@@currentFrame == 3)
        @@currentFrame = 0
        @@currentLvl += 1
        if (@@currentLvl == 3)
          @@currentLvl = 0
          @@currentArea +=1
        end
      end

    end
    print "#{@@currentArea} #{@@currentLvl} #{@@currentFrame}\n"
    print "#{@imageBank[@@currentArea][@@currentLvl][@@currentFrame]}\n"
    @image = Gtk::Image.new(:file => @imageBank[@@currentArea][@@currentLvl][@@currentFrame])
    @buttonImage.set_image(@image)
  end
end

ScenarioUI.new
