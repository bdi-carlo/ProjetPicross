

begin
  require 'rubygems'
 rescue LoadError
end
require 'gtk3'
load "Map.rb"
load "Case.rb"
load "Timers.rb"
load'Score.rb'
load "IndiceFaible.rb"
load "IndiceMoyen.rb"
load "IndiceFort.rb"
#A placer au départ



class Gui
  @difficulte
  attr_accessor :pseudo,:difficulte,:penalite,:score,:highscore,:taille

  def initialize(map,inc,start)
    #Gtk.init

    @inc=inc
    @start=start
    @map = Map.create(map)
    initTimer()
    @indiceFortFlag = FALSE
    @window = Gtk::Window.new.override_background_color(:normal,Gdk::RGBA.new(0,0,0,0))

    @window.set_size_request(970, 700)
    @window.resizable=FALSE
    @window.set_window_position(:center_always)
    # On set le titre
    @window.set_title("Grille")
    # Création du css
    @provider = Gtk::CssProvider.new
    @window.border_width=10
    #Le 10 donne une marge pas mal, c'est proportionel à la taille de la fenetre

    ## GESTION DE LA GRILLE
    #On crée 2 lignes de composants de taille identique (true)
    splitVertical=Gtk::Box.new(:vertical, 0)
    splitVertical.set_homogeneous(FALSE)

    @window.add(splitVertical)


    splitHorizontal=Gtk::Box.new(:horizontal,5)
    splitHorizontal.set_homogeneous(FALSE)

    wintop=initTop
    splitVertical.add(wintop)
    ################################CHIFFRES DES COTÉ######################################
    side = @map.getSide()

    sidenumbers = Gtk::Box.new(:vertical,10)
      for tab in side
        maxlen = 7                                                                            # A FAIRE
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
      splitHorizontal.add(sidenumbers)

    ################################CREATION DE LA GRILLE##################################
    boxinter = Gtk::Box.new(:horizontal,40)
    boxinter.add(initGrid)
    boxinter.add(initBoxAide)
    splitHorizontal.add(boxinter)
    splitVertical.add(splitHorizontal)


    @timer.start
    #On tente de placer le timer en bourrant avec des labels
    boxLabel = Gtk::Box.new(:horizontal,2)
    boxLabel.set_homogeneous(TRUE)
    boxLabel.add(Gtk::Label.new)
    boxLabel.add(@temps)
    boxLabel.add(Gtk::Label.new)
    boxLabel.add(Gtk::Label.new)
    splitVertical.add(boxLabel)
    #Démarage de l'affichage (Bien marquer show_all et pas show)
    @window.show_all

    # Quand la fenetre est détruite il faut quitter
    @window.signal_connect('destroy') {onDestroy}

    #Boucle
    apply_style(@window, @provider)

    Gtk.main
  end
  ##
  # Callback de la fermeture de l'appli
  def onDestroy
    puts "Fin de l'application"
    #Quit 'propre'
    Gtk.main_quit
  end





  #########################################################"TEST###############################################################
  def getTime()
    return @time
  end

  #########################################################
  ##
  # Callback lors du maintient du bouton
  #
  # On teste le bouton actuellement enfoncé et on utilise le ungrab pour changer de bouton
  #
  # Param :
  # * x : Coordonnée du bouton
  # * y : Coordonnée du bouton
  # * button : Event qui contient l'appui
  def onEnter(x,y,button)
    Gdk.pointer_ungrab(Gdk::CURRENT_TIME)
    @buttonTab[x][y].set_focus(TRUE)

    if button.state.button1_mask?
      if @timePress[x][y]%2 == 0

         @buttonTab[x][y].set_image(Gtk::Image.new(:file =>"../images/noir.png"))


         @buttonTab[x][y].set_relief(:none)
         @map.putAt!(x,y,Case.create(1))

     else

        @map.putAt!(x,y,Case.create(0))
        @buttonTab[x][y].set_image(Gtk::Image.new(:file =>"../images/blanc.png"))
        @buttonTab[x][y].set_relief(:none)

     end
      @timePress[x][y]+=1
      if @map.compare                         #####QUOI FAIRE EN CAS DE VICTOIRE
        puts "gagné temps restant : #{@time}"
        Gtk.main_quit
      end
    end
    if button.state.button3_mask?
      @buttonTab[x][y].set_image(Gtk::Image.new(:file =>"../images/croix.png"))
      @buttonTab[x][y].set_relief(:none)
      @map.putAt!(x,y,Case.create(2))
      @timePress[x][y]=0
    end
  end
  ##
  # Callback lors de l'appui d'un bouton
  #
  # Param :
  # * x : Coordonnée du bouton
  # * y : Coordonnée du bouton
  # * button : Event qui contient l'appui
  def onPress(x,y,button)
    Gdk.pointer_ungrab(Gdk::CURRENT_TIME)
    @buttonTab[x][y].set_focus(TRUE)

    if @indiceFortFlag == FALSE
      if button.button==1
        if @timePress[x][y]%2 == 0

           @buttonTab[x][y].set_image(Gtk::Image.new(:file =>"../images/noir.png"))

           @buttonTab[x][y].set_relief(:none)
           @map.putAt!(x,y,Case.create(1))

       else

          @map.putAt!(x,y,Case.create(0))
          @buttonTab[x][y].set_image(Gtk::Image.new(:file =>"../images/blanc.png"))
          @buttonTab[x][y].set_relief(:none)
       end
        @timePress[x][y]+=1

        if @map.compare
          dialog = Gtk::Dialog.new("Bravo",
                                   $main_application_window,
                                   Gtk::Dialog::DESTROY_WITH_PARENT,
                                   [ Gtk::Stock::OK, Gtk::Dialog::RESPONSE_NONE ])

          # Ensure that the dialog box is destroyed when the user responds.
          dialog.signal_connect('response') { dialog.destroy }
          res = "Bravo, vous avez fait un temps de #{@time} s"  #####QUOI FAIRE EN CAS DE VICTOIRE

          dialog.vbox.add(Gtk::Label.new(res))
          dialog.show_all
          Gtk.main_quit
        end
      end
      if button.button==3
        @buttonTab[x][y].set_image(Gtk::Image.new(:file =>"../images/croix.png"))
        @buttonTab[x][y].set_relief(:none)
        @map.putAt!(x,y,Case.create(2))
        @timePress[x][y]=0
      end
    else
      indice = IndiceFort.new(@map,x,y)
      @indiceFortFlag = FALSE
      dialog = Gtk::Dialog.new("Aide3",
                               $main_application_window,
                               Gtk::Dialog::DESTROY_WITH_PARENT,
                               [ Gtk::Stock::OK, Gtk::Dialog::RESPONSE_NONE ])

      # Ensure that the dialog box is destroyed when the user responds.
      dialog.signal_connect('response') { dialog.destroy }

      # Add the message in a label, and show everything we've added to the dialog.
      dialog.vbox.add(Gtk::Label.new(indice.envoyerIndice.indice))
      dialog.show_all
    end
  end

  def aide1()
    indice = IndiceFaible.new(@map)
    dialog = Gtk::Dialog.new("Aide1",
                             $main_application_window,
                             Gtk::Dialog::DESTROY_WITH_PARENT,
                             [ Gtk::Stock::OK, Gtk::Dialog::RESPONSE_NONE ])

    # Ensure that the dialog box is destroyed when the user responds.
    dialog.signal_connect('response') { dialog.destroy }

    # Add the message in a label, and show everything we've added to the dialog.
    dialog.vbox.add(Gtk::Label.new(indice.envoyerIndice.indice))
    dialog.show_all
    @timer.add(10)

  end

  def aide2()
    indice = IndiceMoyen.create(@map)
    dialog = Gtk::Dialog.new("Aide2",
                             $main_application_window,
                             Gtk::Dialog::DESTROY_WITH_PARENT,
                             [ Gtk::Stock::OK, Gtk::Dialog::RESPONSE_NONE ])

    # Ensure that the dialog box is destroyed when the user responds.
    dialog.signal_connect('response') { dialog.destroy }

    # Add the message in a label, and show everything we've added to the dialog.
    dialog.vbox.add(Gtk::Label.new(indice.envoyerIndice.indice))
    dialog.show_all
    @timer.add(15)
  end

  def aide3()

    @indiceFortFlag = TRUE
  end

  ##
  # Crée le timer
  #
  # Retour : Le timer créé
  def initTimer()
    @timer = Timers.new(@inc,@start){
      @time=@timer.getTime
      if @time > 0
        @temps.set_markup("<span color=\"#33FF00\" weight=\"bold\" size=\"large\" > #{@time} </span>")
      else
        @temps.set_markup("<span color=\"#33FF00\" weight=\"bold\" size=\"large\" > Time's up </span>")
        puts "Perdu" #############QUOI FAIRE EN CAS DE DEFAITE
        @timer.stop
        Gtk.main_quit
      end
    }

    @temps=Gtk::Label.new()
    @time = 50
    @timePress=Array.new{Array.new}
  end
  ##
  # Crée la zone des chiffres du dessus
  #
  # Retour : la zone crée
  def initTop()
    top = @map.getTop()
    maxlen= 5                                                                                         #A MODIFIER
    @temp =[]
    topnumbers = Gtk::Box.new(:vertical,2)
    topnumbers.homogeneous=(TRUE)
    # On boucle sur les chiffres du dessus partant du haut et en mettant un blanc si y'a rien
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
      # Pour écrire en vert
      label = label.set_markup("<span color=\"#33FF00\" >#{@temp.join}</span>")
      @temp.clear
      topnumbers.add(label)
    end
    wintop = Gtk::Box.new(:horizontal,100)
    wintop.add(topnumbers)
    wintop.add(Gtk::Label.new("     "))
  end
  ##
  # Boite contenant les boutons
  #
  # Retour : la boite crée et initialisée
  def initBoxAide()
    boxAide = Gtk::Box.new(:vertical,100)
    boxAide.add(Gtk::Label.new())

    hbox2 = Gtk::Box.new(:horizontal,10)
    aide1 = Gtk::Button.new().set_label("Aide 1").set_size_request(100,10).set_xalign(0.5)
    aide1.signal_connect("clicked"){aide1()}
    hbox2.add(aide1)
    hbox2.add(Gtk::Label.new().set_markup("<span color=\"#33FF00\" >10 secondes     </span>"))

    boxAide.add(hbox2)
    hbox3 = Gtk::Box.new(:horizontal,10)
    aide2 = Gtk::Button.new().set_label("Aide 2").set_size_request(100,10).set_xalign(0.5)
    aide2.signal_connect("clicked"){aide2()}
    hbox3.add(aide2)
    hbox3.add(Gtk::Label.new().set_markup("<span color=\"#33FF00\" >15 secondes     </span>"))
    boxAide.add(hbox3)

    hbox4 = Gtk::Box.new(:horizontal,10)
    aide3 = Gtk::Button.new().set_label("Aide 3").set_size_request(100,10).set_xalign(0.5)
    aide3.signal_connect("clicked"){aide3()}
    hbox4.add(aide3)
    hbox4.add(Gtk::Label.new().set_markup("<span color=\"#33FF00\" >20 secondes     </span>"))
    boxAide.add(hbox4)
    boxAide.name = "boxAide"
    @provider.load(:data=>"#boxAide {background-image : url(\"../images/zoneaide.png\");
                                      background-repeat:no-repeat;
                                      background-position:100% 100%;
                                    }")
    return boxAide

  end
  ##
  # Crée la grille en format gtk
  #
  # Retour : grille de bouton
  def initGrid()
    @buttonTab = Array.new{Array.new}
    i=0

    grid = Gtk::Box.new(:vertical,0)
    grid.set_homogeneous(TRUE)
    0.upto(@map.getRows-1) do |x|
      row = Gtk::Box.new(:horizontal,0)
      row.set_homogeneous(TRUE)
      tabrow = Array.new
      tabPress = Array.new
      0.upto(@map.getCols-1) do |y|
        button=Gtk::Button.new().set_size_request(15,15)
        button.set_relief(:none)
        tabrow.push(button)
        tabPress.push(0)
        button.set_image(Gtk::Image.new(:file =>"../images/blanc.png"))
        button.set_always_show_image(TRUE)
        button.set_focus(FALSE)

        #### On connecte les boutons aux fonctions
        button.signal_connect("button_press_event"){

            onPress(x,y,Gtk.current_event)
        }
        button.signal_connect("enter"){

            onEnter(x,y,Gtk.current_event)
        }

        i+=1

        row.add(button)
      end
      @buttonTab.push(tabrow)
      @timePress.push(tabPress)
      grid.add(row)
    end
    return grid
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

#Gui.new("./grilles/Scenario/Bateau",1,0)
