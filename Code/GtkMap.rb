

begin
  require 'rubygems'
 rescue LoadError
end
require 'gtk3'
load "Map.rb"
load "Case.rb"
load "Timers.rb"
#A placer au départ

class Gui
  def initialize
    Gtk.init
    @map = Map.create("./grilles/Scenario/Bateau")

    @timer = Timers.new(-1,300){
      @time=@timer.getTime
      if @time > 0
        @temps.set_markup("<span color=\"#33FF00\" weight=\"bold\" size=\"large\" > #{@time} </span>")
      else
        @temps.set_markup("<span color=\"#33FF00\" weight=\"bold\" size=\"large\" > Time's up </span>")
        puts "Perdu"
        @timer.stop
        Gtk.main_quit
      end
    }
    @temps=Gtk::Label.new()
    @time = 50
    ##COSMETIQUE DE LA FENETRE
    # On crée une fenetre
    @timePress=Array.new{Array.new}

    @window = Gtk::Window.new.override_background_color(:normal  , Gdk::RGBA.new())
    @window.set_size_request(970, 700)
    @window.resizable=FALSE
    @window.set_window_position( Gtk::WindowPosition::CENTER_ALWAYS)
    # On set le titre
    @window.set_title("Test GTK")

    # Position de la fenetre
    @provider = Gtk::CssProvider.new

    # Taille de la fenêtre

    # Réglage de la bordure
    @window.border_width=10
    #Le 10 donne une marge pas mal, c'est proportionel à la taille de la fenetre

    ## GESTION DE LA GRILLE
    #On crée 2 lignes de composants de taille identique (true)
    vbox1=Gtk::Box.new(:vertical, 0)
    vbox1.set_homogeneous(FALSE)

    @window.add(vbox1)


    hbox1=Gtk::Box.new(:horizontal,5)
    hbox1.set_homogeneous(FALSE)


    ##############################CHIFFRES DU DESSUS ####################################
    top = @map.getTop()
    maxlen= 5
    @temp =[]
    topnumbers = Gtk::Box.new(:vertical,2)
    topnumbers.homogeneous=(TRUE)
    maxlen.downto(0) do |i|
      @temp<< "                                       "
      0.upto(@map.getCols-1) do |j|

        if top[j][i]!=nil
          if top[j].reverse[i]<10
          @temp << " #{top[j].reverse[i]}      "
          else
          @temp << " #{top[j].reverse[i]}     "
          end
        else
          @temp << "         "
        end

      end

      label = Gtk::Label.new(@temp.join)
      label = label.set_markup("<span color=\"#33FF00\" >#{@temp.join}</span>")
      @temp.clear
      topnumbers.add(label)
    end
    wintop = Gtk::Box.new(:horizontal,100)
    wintop.add(topnumbers)
    wintop.add(Gtk::Label.new("     "))
    vbox1.add(wintop)
    ################################CHIFFRES DES COTÉ######################################
    side = @map.getSide()

    sidenumbers = Gtk::Box.new(:vertical,10)
      for tab in side
        maxlen = 7
        tab.length.upto(maxlen)do
          @temp << "   "
        end
        0.upto(tab.length()-1) do |i|
            @temp << " #{tab[i]} "
        end
        label = Gtk::Label.new(@temp.join)
        label = label.set_markup("<span color=\"#33FF00\" >#{@temp.join}</span>")
        @temp.clear
        sidenumbers.add(label)
      end
      hbox1.add(sidenumbers)

    ################################CREATION DE LA GRILLE##################################
    @buttonTab = Array.new{Array.new}
    i=0
    boxinter = Gtk::Box.new(:horizontal,40)
    grid = Gtk::Box.new(:vertical,0)
    grid.set_homogeneous(TRUE)
    0.upto(@map.getRows-1) do |x|
      row = Gtk::Box.new(:horizontal,0)
      row.set_homogeneous(TRUE)
      tabrow = Array.new
      tabPress = Array.new
      0.upto(@map.getCols-1) do |y|
        button=Gtk::Button.new(:expand => FALSE).set_size_request(15,15)
        button.set_relief(Gtk::RELIEF_NONE)
        tabrow.push(button)
        tabPress.push(0)
        button.set_image(Gtk::Image.new(:file =>"images/blanc.png"))
        button.set_always_show_image(TRUE)
        button.signal_connect("button_press_event"){
            onPress(x,y,Gtk.current_event.button)
        }
        i+=1
        row.add(button)
      end
      @buttonTab.push(tabrow)
      @timePress.push(tabPress)
      grid.add(row)
    end
    #hbox1.add(grid)
    boxAide = Gtk::Box.new(:vertical,100)
    boxAide.add(Gtk::Label.new())

    hbox2 = Gtk::Box.new(:horizontal,10)
    hbox2.add(Gtk::Button.new().set_label("Aide 1").set_size_request(100,10).set_xalign(0.5))
    hbox2.add(Gtk::Label.new().set_markup("<span color=\"#33FF00\" >10 secondes     </span>"))
    boxAide.add(hbox2)
    hbox3 = Gtk::Box.new(:horizontal,10)
    hbox3.add(Gtk::Button.new().set_label("Aide 2").set_size_request(100,10).set_xalign(0.5))
    hbox3.add(Gtk::Label.new().set_markup("<span color=\"#33FF00\" >15 secondes     </span>"))
    boxAide.add(hbox3)
    boxAide.name = "boxAide"
    @provider.load(:data=>"#boxAide {background-image : url(\"images/zoneaide.png\");
                                      background-repeat:no-repeat;
                                      background-position:100% 100%;
                                    }")
    boxinter.add(grid)
    boxinter.add(boxAide)
    hbox1.add(boxinter)
    vbox1.add(hbox1)


    @timer.start
    #On tente de placer le timer en bourrant avec des labels
    boxLabel = Gtk::Box.new(:horizontal,2)
    boxLabel.set_homogeneous(TRUE)
    boxLabel.add(Gtk::Label.new)
    boxLabel.add(@temps)
    boxLabel.add(Gtk::Label.new)
    boxLabel.add(Gtk::Label.new)
    vbox1.add(boxLabel)
    #Démarage de l'affichage (Bien marquer show_all et pas show)
    @window.show_all

    # Quand la fenetre est détruite il faut quitter
    @window.signal_connect('destroy') {onDestroy}

    #Boucle
    apply_style(@window, @provider)
    print @window.size
    Gtk.main
  end
  def onDestroy
    puts "Fin de l'application"
    #Quit 'propre'
    Gtk.main_quit
  end

  def onPress(x,y,button)
    print "#{button}\n"
    #@buttonTab[x*y+y].image=(@noir)
    if button != 3
      if @timePress[x][y]%2 == 0

         @buttonTab[x][y].set_image(Gtk::Image.new(:file =>"images/noir.png"))
         #@buttonTab[x][y].child().set_property('xscale', 1.0)
         #@buttonTab[x][y].child().set_property('yscale', 1.0)
         @buttonTab[x][y].set_relief(Gtk::RELIEF_NONE)
         @map.putAt!(x,y,Case.create(1))

     else

        @map.putAt!(x,y,Case.create(0))
        @buttonTab[x][y].set_image(Gtk::Image.new(:file =>"images/blanc.png"))
        @buttonTab[x][y].set_relief(Gtk::RELIEF_NONE)
        #@buttonTab[x][y].child().set_property('xscale', 1.0)
        #@buttonTab[x][y].child().set_property('yscale', 1.0)
     end
      @timePress[x][y]+=1
      print "\nj'ai appuyé à la case #{x},#{y}\n"
      if @map.compare
        puts "gagné temps restant : #{@time}"
        Gtk.main_quit
      end
    else
      @buttonTab[x][y].set_image(Gtk::Image.new(:file =>"images/croix.png"))
      #@buttonTab[x][y].child().set_property('xscale', 1.0)
      #@buttonTab[x][y].child().set_property('yscale', 1.0)
      @buttonTab[x][y].set_relief(Gtk::RELIEF_NONE)
      @map.putAt!(x,y,Case.create(2))
      @timePress[x][y]=0
    end
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

Gui.new
