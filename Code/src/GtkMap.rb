begin
  require 'rubygems'
 rescue LoadError
end
require 'gtk3'
require "date"
require "yaml"

load "Map.rb"
load "Case.rb"
load "Timers.rb"
load 'Score.rb'
load "Hypothese.rb"
load "IndiceFaible.rb"
load "IndiceMoyen.rb"
load "IndiceFort.rb"
#A placer au départ

class Gui

  @difficulte

  attr_accessor :pseudo, :difficulte, :penalite, :score, :highscore, :taille, :time, :nomMap

	# Initialize en cas de nouvelle partie
  def initialize( charge, pseudo, cheminMap, inc, start, map, hypo, nbHypo )
		# Tableau pour gerer les couleurs des hypotheses
		@tabCase = ["../images/cases/noir.png", "../images/cases/violet.png", "../images/cases/bleu.png", "../images/cases/rouge.png"]
		@tabCaseOver = ["../images/cases/noirOver.png", "../images/cases/violetOver.png", "../images/cases/bleuOver.png", "../images/cases/rougeOver.png"]
		@inc = inc
		@start = start
		@cheminMap = cheminMap
		@pseudo = pseudo

		if charge == 0 then
			@nbHypo = 0
			@map = Map.create(cheminMap)
			@hypo = Hypothese.creer(@map)
		elsif charge == 1
			@nbHypo = nbHypo
			@map = map
			@hypo = hypo
		end

		initTimer()
		lancerGrille()
  end

	##
	# Méthode qui permet de récupérer le nom de la map grâce au chemin de la grille
	def recupNom( unString )
		res = ""
		unString.reverse.each_char{ |x|
			if x == '/'
				return res.reverse
			else
				res << x
			end
		}
		return res.reverse
	end

  ##
  # Callback de la fermeture de l'appli
  def onDestroy
    puts "Fermeture picross"
    sauvegarder(@pseudo+"_"+recupNom(@cheminMap), self)
    Gtk.main_quit
  end

	def lancerGrille()
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


    splitHorizontal=Gtk::Box.new(:horizontal,20)
    splitHorizontal.set_homogeneous(FALSE)

    wintop=initTop
    splitVertical.add(wintop)
    ################################CHIFFRES DES COTÉ######################################
    side = @map.side
    maxlen = 0
    for tab in side
      if tab.length > maxlen
        maxlen = tab.length
      end
    end
    sidenumbers = Gtk::Box.new(:vertical,10)
      #sidenumbers.add(Gtk::Label.new())
      for tab in side
                                                                                   # A FAIRE
        tab.length.upto(maxlen)do
          @temp << "   "
        end
        if tab == []
          @temp << " 0 "
        else
          0.upto(tab.length()-1) do |i|
              @temp << " #{tab[i]} "
          end
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
		boxinter.add(initBoxHypo)
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

  #########################################################"TEST###############################################################

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

        @buttonTab[x][y].remove(@buttonTab[x][y].child)
        @buttonTab[x][y].child = (Gtk::Image.new(:file => @tabCase[@nbHypo]))

        @buttonTab[x][y].show_all


         @map.putAt!(x,y,Case.create(1))
         @map.accessAt(x,y).color=@nbHypo
         #print "Color sur le enter #{@map.accessAt(x,y).color}\n"
      else

        @map.putAt!(x,y,Case.create(0))
        @buttonTab[x][y].remove(@buttonTab[x][y].child)
        @buttonTab[x][y].child = (Gtk::Image.new(:file =>"../images/cases/blanc.png"))
        @buttonTab[x][y].show_all

      end
      @timePress[x][y]+=1
      if @map.compare                         #####QUOI FAIRE EN CAS DE VICTOIRE
        dialog = Gtk::Dialog.new("Bravo",
                                 $main_application_window,
                                 Gtk::DialogFlags::DESTROY_WITH_PARENT,
                                 [ Gtk::Stock::OK, Gtk::ResponseType::NONE ])

        # Ensure that the dialog box is destroyed when the user responds.
        dialog.signal_connect('response') { @window.destroy
          puts "Fermeture picross sur victoire"
          dialog.destroy
         }
        res = "Bravo, vous avez fait un temps de #{@time} s"  #####QUOI FAIRE EN CAS DE VICTOIRE

        dialog.vbox.add(Gtk::Label.new(res))
        dialog.show_all


      end
    elsif button.state.button3_mask?
      @buttonTab[x][y].remove(@buttonTab[x][y].child)
      @buttonTab[x][y].child = (Gtk::Image.new(:file =>"../images/cases/croix.png"))
      @buttonTab[x][y].show_all
      @map.putAt!(x,y,Case.create(2))
      @timePress[x][y]=0

    #MouseOver : changement des images au survol de la case

    else
      if (@map.accessAt(x,y).value == 0)
          @buttonTab[x][y].remove(@buttonTab[x][y].child)
          @buttonTab[x][y].child = (Gtk::Image.new(:file =>"../images/cases/blancOver.png"))
          @buttonTab[x][y].show_all


      elsif (@map.accessAt(x,y).value == 1)
        #  print "color =#{@map.accessAt(x,y).color}\n"
          if @map.accessAt(x,y).color != nil
            if (@map.accessAt(x,y).color == @nbHypo + 1)
              @timePress[x][y] = 1
              @map.accessAt(x,y).color = @nbHypo
            end
              @buttonTab[x][y].remove(@buttonTab[x][y].child)
              #print "path = #{@tabCase[@map.accessAt(x,y).color]}\n"
              @buttonTab[x][y].child = (Gtk::Image.new(:file => @tabCaseOver[@map.accessAt(x,y).color]))
              @buttonTab[x][y].show_all
          end

      elsif(@map.accessAt(x,y).value == 2)
          @buttonTab[x][y].remove(@buttonTab[x][y].child)
          @buttonTab[x][y].child = (Gtk::Image.new(:file =>"../images/cases/croixOver.png"))
          @buttonTab[x][y].show_all
      end

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

          @buttonTab[x][y].remove(@buttonTab[x][y].child)
          @buttonTab[x][y].child = (Gtk::Image.new(:file => @tabCase[@nbHypo]))
          @buttonTab[x][y].show_all
           @map.putAt!(x,y,Case.create(1))
           @map.accessAt(x,y).color=@nbHypo
           #print "Color sur le press #{@map.accessAt(x,y).color}\n"

       else

          @map.putAt!(x,y,Case.create(0))
          @buttonTab[x][y].remove(@buttonTab[x][y].child)
          @buttonTab[x][y].child =(Gtk::Image.new(:file => "../images/cases/blanc.png"))
          @buttonTab[x][y].show_all
       end
        @timePress[x][y]+=1

        if @map.compare
          dialog = Gtk::Dialog.new("Bravo",
                                   $main_application_window,
                                   Gtk::Dialog::DESTROY_WITH_PARENT,
                                   [ Gtk::Stock::OK, Gtk::Dialog::RESPONSE_NONE ])

          # Ensure that the dialog box is destroyed when the user responds.
          dialog.signal_connect('response') { @window.destroy
            puts "Fermeture picross sur victoire"
            dialog.destroy
          }
          res = "Bravo, vous avez fait un temps de #{@time} s"  #####QUOI FAIRE EN CAS DE VICTOIRE

          dialog.vbox.add(Gtk::Label.new(res))
          dialog.show_all


        end
      end
      if button.button==3
        @buttonTab[x][y].remove(@buttonTab[x][y].child)
        @buttonTab[x][y].child = (Gtk::Image.new(:file =>"../images/cases/croix.png"))
        @buttonTab[x][y].show_all
        @map.putAt!(x,y,Case.create(2))
        @timePress[x][y]= 0
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
                             Gtk::DialogFlags::DESTROY_WITH_PARENT,
                             [ Gtk::Stock::OK, Gtk::ResponseType::NONE ])

    # Ensure that the dialog box is destroyed when the user responds.
    dialog.signal_connect('response') { dialog.destroy }

    # Add the message in a label, and show everything we've added to the dialog.
    dialog.child.add(Gtk::Label.new(indice.envoyerIndice.indice))
    dialog.show_all
    @timer.add(10)

  end

  def aide2()
    indice = IndiceMoyen.create(@map)
    dialog = Gtk::Dialog.new("Aide2",
                             $main_application_window,
                             Gtk::DialogFlags::DESTROY_WITH_PARENT,
                             [ Gtk::Stock::OK, Gtk::ResponseType::NONE ])

    # Ensure that the dialog box is destroyed when the user responds.
    dialog.signal_connect('response') { dialog.destroy }

    # Add the message in a label, and show everything we've added to the dialog.
    dialog.child.add(Gtk::Label.new(indice.envoyerIndice.indice))
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
      @time=@timer.time
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
    top = @map.top()
    maxlen = 0;

    for tab in top
      if tab.length > maxlen
        maxlen = tab.length
      end
    end
    splitHorizontal=Gtk::Box.new(:horizontal,5)
    splitHorizontal.set_homogeneous(FALSE)                                                                                        #A MODIFIER
    @temp =[]
    topnumbers = Gtk::Box.new(:horizontal,18)
    topnumbers.homogeneous=(TRUE)
########################################################################################################

      for tab in top
        tab.length.upto(maxlen) do
          @temp << "\n"
        end
        if tab == []
          @temp << "0\n"
        else
          0.upto(tab.length()-1) do |i|
              @temp << "#{tab[i]}\n"
          end
        end
        label = Gtk::Label.new(@temp.join)
        label = label.set_markup("<span color=\"#33FF00\" >#{@temp.join}</span>")
        @temp.clear
        topnumbers.add(label)

      end
      wintop = Gtk::Box.new(:horizontal,100)
      splitHorizontal.add(Gtk::Label.new(" "*28))
      splitHorizontal.add(topnumbers)
      wintop.add(splitHorizontal)
      wintop.add(Gtk::Label.new("     "))
  end

  ##
  # Boite contenant les boutons
  #
  # Retour : la boite crée et initialisée
  def initBoxAide()
    boxAide = Gtk::Box.new(:vertical,50)
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

    return boxAide

  end

	##
  # Boite contenant les boutons
  #
  # Retour : la boite crée et initialisée
  def initBoxHypo()
    boxHypo = Gtk::Box.new(:vertical,50)
    boxHypo.add(Gtk::Label.new())

    hbox2 = Gtk::Box.new(:horizontal,10)
    bFaire = Gtk::Button.new().set_label("Faire hypothese").set_size_request(100,10).set_xalign(0.5)
    bFaire.signal_connect("clicked"){
			if @nbHypo < 3
				@nbHypo += 1
				@map = @hypo.faireHypothese()
			end
		}
    hbox2.add(bFaire)
		boxHypo.add(hbox2)

    hbox3 = Gtk::Box.new(:horizontal,10)
    bValider = Gtk::Button.new().set_label("Valier hypothese").set_size_request(100,10).set_xalign(0.5)
    bValider.signal_connect("clicked"){
			@nbHypo -= 1
			@map = @hypo.validerHypothese()
      actuMap()
		}
    hbox3.add(bValider)
    boxHypo.add(hbox3)

    hbox4 = Gtk::Box.new(:horizontal,10)
    bRejeter = Gtk::Button.new().set_label("Rejeter hypothese").set_size_request(100,10).set_xalign(0.5)
    bRejeter.signal_connect("clicked"){
			if @nbHypo > 0
				@nbHypo -= 1
				@map = @hypo.rejeterHypothese()
        actuMap()
			end
		}
    hbox4.add(bRejeter)
    boxHypo.add(hbox4)

    boxHypo.name = "boxHypo"

    return boxHypo

  end

  ##
  # Crée la grille en format gtk
  #
  # Retour : grille de bouton
  def initGrid()
    @buttonTab = Array.new{Array.new}
    i=0

    grid = Gtk::Box.new(:vertical,2)
    grid.set_homogeneous(FALSE)
    0.upto(@map.rows-1) do |x|
      row = Gtk::Box.new(:horizontal,2)
      row.set_homogeneous(FALSE)
      tabrow = Array.new
      tabPress = Array.new
      0.upto(@map.cols-1) do |y|
        button=Gtk::EventBox.new()

        tabrow.push(button)
        tabPress.push(0)
        button.add(Gtk::Image.new(:file =>"../images/cases/blanc.png"))

        button.set_focus(FALSE)

        #### On connecte les boutons aux fonctions
        button.signal_connect("button_press_event"){
            onPress(x,y,Gtk.current_event)
        }
        button.signal_connect("enter_notify_event"){
            onEnter(x,y,Gtk.current_event)
        }

        button.signal_connect("leave_notify_event"){
          actuMap()
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

  def actuMap()
    0.upto(@map.rows-1) do |x|
      0.upto(@map.cols-1) do |y|
        #print("value =#{@map.accessAt(x,y).value}\n")
        if (@map.accessAt(x,y).value == 1)
        #  print "color =#{@map.accessAt(x,y).color}\n"
          if @map.accessAt(x,y).color != nil
            if (@map.accessAt(x,y).color == @nbHypo + 1)
              @timePress[x][y] = 1
              @map.accessAt(x,y).color = @nbHypo
            end
              @buttonTab[x][y].remove(@buttonTab[x][y].child)
              #print "path = #{@tabCase[@map.accessAt(x,y).color]}\n"
              @buttonTab[x][y].child = (Gtk::Image.new(:file => @tabCase[@map.accessAt(x,y).color]))
              @buttonTab[x][y].show_all

          else
            @buttonTab[x][y].remove(@buttonTab[x][y].child)
            @buttonTab[x][y].child = (Gtk::Image.new(:file => "../images/cases/blanc.png" ))
            @timePress[x][y] = 0
            @buttonTab[x][y].show_all
          end
        elsif @map.accessAt(x,y).value == 2
          @buttonTab[x][y].remove(@buttonTab[x][y].child)
          @buttonTab[x][y].child = (Gtk::Image.new(:file => "../images/cases/croix.png" ))
          @timePress[x][y] = 0
          @buttonTab[x][y].show_all

        else
          @buttonTab[x][y].remove(@buttonTab[x][y].child)
          @buttonTab[x][y].child = (Gtk::Image.new(:file => "../images/cases/blanc.png" ))
          @timePress[x][y] = 0
          @buttonTab[x][y].show_all

        end

      end

    end
  end

	##
	# Sauvegarde la partie
	#
	# Param : identificateurs d'une partie
	def sauvegarder(unNom, uneGrille)
		# Serialisation des différentes classes
		map = @map.to_yaml()
		hypo = @hypo.to_yaml()

		# Ecriture dans le fichier
		monFichier = File.open("../sauvegardes/"+unNom, "w")
		monFichier.write(map)
		monFichier.write("***\n")
		monFichier.write(hypo)
		monFichier.write("***\n")
		monFichier.write(@pseudo)
		monFichier.write("\n***\n")
		monFichier.write(@inc)
		monFichier.write("\n***\n")
		monFichier.write(@start)
		monFichier.write("\n***\n")
		monFichier.write(@cheminMap)
		monFichier.write("\n***\n")
		monFichier.write(@nbHypo)
		monFichier.write("\n***\n")

		# Fermeture du fichier
		monFichier.close
	end

end
