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
  def initialize( indiceTypeJeu, charge, pseudo, cheminMap, inc, start, map, hypo, nbHypo )
		# Tableau pour gerer les couleurs des hypotheses
		@tabCase = ["../images/cases/noir.png", "../images/cases/violet.png", "../images/cases/bleu.png", "../images/cases/rouge.png"]
		@tabCaseOver = ["../images/cases/noirOver.png", "../images/cases/violetOver.png", "../images/cases/bleuOver.png", "../images/cases/rougeOver.png"]
		@inc = inc
		@start = start
		@cheminMap = cheminMap
		@pseudo = pseudo
    @save_flag=true
		@indiceTypeJeu = indiceTypeJeu
		@flagHypo=false
		if charge == 0 then
			@nbHypo = 0
			@map = Map.create(cheminMap)
			@hypo = Hypothese.creer(@map)
		elsif charge == 1
			@nbHypo = nbHypo
			@map = map
			@hypo = hypo
		end

		@tabFaireHypo = ["../images/boutons/hypo/faireNoir.png","../images/boutons/hypo/faireViolet.png","../images/boutons/hypo/faireBleu.png","../images/boutons/hypo/faireRouge.png"]
		@tabFaireHypoOver = ["../images/boutons/hypo/faireNoirOver.png","../images/boutons/hypo/faireVioletOver.png","../images/boutons/hypo/faireBleuOver.png","../images/boutons/hypo/faireRougeOver.png"]
		@tabValiderHypo = ["../images/boutons/hypo/validerNoir.png","../images/boutons/hypo/validerViolet.png","../images/boutons/hypo/validerBleu.png","../images/boutons/hypo/validerRouge.png"]
		@tabValiderHypoOver = ["../images/boutons/hypo/validerNoirOver.png","../images/boutons/hypo/validerVioletOver.png","../images/boutons/hypo/validerBleuOver.png","../images/boutons/hypo/validerRougeOver.png"]
		@tabRejeterHypo = ["../images/boutons/hypo/rejeterNoir.png","../images/boutons/hypo/rejeterViolet.png","../images/boutons/hypo/rejeterBleu.png","../images/boutons/hypo/rejeterRouge.png"]
		@tabRejeterHypoOver = ["../images/boutons/hypo/rejeterNoirOver.png","../images/boutons/hypo/rejeterVioletOver.png","../images/boutons/hypo/rejeterBleuOver.png","../images/boutons/hypo/rejeterRougeOver.png"]

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
  def onDestroy()
		if @save_flag == true && @indiceTypeJeu == 0
			save?()
		end

		puts surQuitter?()


    Gtk.main_quit
    @window.destroy

		if @indiceTypeJeu != 2
			MenuPrincipal.new(@pseudo)
		end
  end

	##
	#Méthode qui demande à l'utilisateur si il est sur de vouloir quitter ou non
	def surQuitter?()
		quitter = false
		dialog = Gtk::Dialog.new("Quitter?",
                             $main_application_window,
                             Gtk::DialogFlags::MODAL | Gtk::DialogFlags::DESTROY_WITH_PARENT,
                             [ Gtk::Stock::YES, Gtk::ResponseType::ACCEPT ],
													 	 [ Gtk::Stock::NO, Gtk::ResponseType::REJECT ])
		dialog.set_window_position(:center_always)

    # Ensure that the dialog box is destroyed when the user responds.

    # Add the message in a label, and show everything we've added to the dialog.
    dialog.child.add(Gtk::Label.new( "\nVoulez-vous vraiment quitter, car pas de sauvegarde en mode compétitif\n" ))

		dialog.show_all

		dialog.signal_connect('response') { |dial,rep|
			if rep == -3
				quitter = true
			end
		}
		dialog.destroy
		return quitter
	end

	##
	#Méthode qui demande à l'utilisateur de sauvegarder ou non
	def save?()
		dialog = Gtk::Dialog.new("Sauvegarde?",
                             $main_application_window,
                             Gtk::DialogFlags::MODAL | Gtk::DialogFlags::DESTROY_WITH_PARENT,
                             [ Gtk::Stock::YES, Gtk::ResponseType::ACCEPT ],
													 	 [ Gtk::Stock::NO, Gtk::ResponseType::REJECT ])
		dialog.set_window_position(:center_always)

    # Ensure that the dialog box is destroyed when the user responds.

    # Add the message in a label, and show everything we've added to the dialog.
    dialog.child.add(Gtk::Label.new( "\nVoulez-vous enregistrer votre partie en cours?\n" ))

		dialog.show_all

		dialog.signal_connect('response') { |dial,rep|
			if rep == -3
				sauvegarder( @pseudo+"_"+recupNom(@cheminMap) )
			end
			dialog.destroy
		}
	end

	def lancerGrille()
		@indiceFortFlag = FALSE

		#Création de la fenêtre
		@window = Gtk::Window.new("PiCross")

    @window.resizable=FALSE
    @window.set_window_position(:center_always)

		grid = Gtk::Grid.new
		hb = Gtk::Box.new(:horizontal, 10)
		@vb = Gtk::Box.new(:vertical, 20)

    @window.add(grid)

		#Label de bordure haut
		@vb.add(Gtk::Label.new(""))

    splitHorizontal=Gtk::Box.new(:horizontal,20)
    splitHorizontal.set_homogeneous(FALSE)

    ################################CHIFFRES DES COTÉ######################################
    @temp=[]
    side = @map.side
    @maxlens = 0
    for tab in side
      if tab.length > @maxlens
        @maxlens = tab.length
      end

    end
    sidenumbers = Gtk::Box.new(:vertical,10)
      #sidenumbers.add(Gtk::Label.new())
      for tab in side
                                                                                   # A FAIRE
        tab.length.upto(@maxlens)do
          @temp << "   "
        end
        if tab == []
          @temp << " 0 "
        else
          0.upto(tab.length()-1) do |i|
              @temp << " #{tab[i]} "
          end
          @temp << " "
        end
        label = Gtk::Label.new(@temp.join)
        label = label.set_markup("<span foreground='white' >#{@temp.join}</span>")
        @temp.clear
        sidenumbers.add(label)
      end
      splitHorizontal.add(sidenumbers)

    ################################CREATION DE LA GRILLE##################################
    boxinter = Gtk::Box.new(:horizontal,40)
    wintop=initTop
    @vb.add(wintop)
    boxinter.add(initGrid)
    boxinter.add(initBoxAide)
		boxinter.add(initBoxHypo)
		boxinter.add(initBoxBoutons)
    splitHorizontal.add(boxinter)
    @vb.add(splitHorizontal)


    @timer.start
    #On tente de placer le timer en bourrant avec des labels
    boxLabel = Gtk::Box.new(:horizontal,2)
    boxLabel.set_homogeneous(TRUE)
    boxLabel.add(Gtk::Label.new)
    boxLabel.add(@temps)
    boxLabel.add(Gtk::Label.new)
    boxLabel.add(Gtk::Label.new)
    @vb.add(boxLabel)

		grid.attach(@vb,0,0,1,1)

		#Wallpaper
		if @map.rows > 11
			image = Gtk::Image.new(:file => "../images/wallpaperInGameGrand.jpg")
		else
			image = Gtk::Image.new(:file => "../images/wallpaperInGamePetit.jpg")
		end
		grid.attach(image,0,0,1,1)

    #Démarage de l'affichage (Bien marquer show_all et pas show)
    @window.show_all

    # Quand la fenetre est détruite il faut quitter
    @window.signal_connect('destroy') {onDestroy}

		actuMap()

    Gtk.main
	end

  #########################################################"TEST###############################################################

  #########################################################
  ##
  # Callback lors du maintient du bouton
  #
  # On teste le bouton actuellement enfoncé et on utilise le ungrab pour change de bouton
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
        changeImage(@buttonTab[x][y],@tabCase[@nbHypo])

       @map.putAt!(x,y,Case.create(1))
       @map.accessAt(x,y).color=@nbHypo
       #print "Color sur le enter #{@map.accessAt(x,y).color}\n"
      else
        @map.putAt!(x,y,Case.create(0))
      	changeImage(@buttonTab[x][y],"../images/cases/blanc.png")
      end
      @timePress[x][y]+=1
      if @map.compare                      #####QUOI FAIRE EN CAS DE VICTOIRE
				victoire()
      end
    elsif button.state.button3_mask?
      changeImage(@buttonTab[x][y],"../images/cases/croix.png")
      @map.putAt!(x,y,Case.create(2))
      @timePress[x][y]=0

    #MouseOver : changement des images au survol de la case

    else
      if (@map.accessAt(x,y).value == 0)
        ajoutLimitationOver(x,y)
				surlignageLigneColonne(1,x,y)
      elsif (@map.accessAt(x,y).value == 1)
        #  print "color =#{@map.accessAt(x,y).color}\n"
          if @map.accessAt(x,y).color != nil
            if (@map.accessAt(x,y).color == @nbHypo + 1)
              @timePress[x][y] = 1
              @map.accessAt(x,y).color = @nbHypo
            end
              changeImage(@buttonTab[x][y],@tabCaseOver[@map.accessAt(x,y).color])
							surlignageLigneColonne(1,x,y)
          end

      elsif(@map.accessAt(x,y).value == 2)
          changeImage(@buttonTab[x][y],"../images/cases/croixOver.png")
					surlignageLigneColonne(1,x,y)
      end

    end
  end

	##
	#Méthode qui aplique ce qu'il y a faire lors de la victoire
	def victoire()
		@timer.pause
		dialog = Gtk::Dialog.new("Bravo",
														 $main_application_window,
														 Gtk::DialogFlags::DESTROY_WITH_PARENT,
														 [ Gtk::Stock::OK, Gtk::ResponseType::ACCEPT ])

		if @indiceTypeJeu == 1 then
			enregistreScore()
		end

		# Ensure that the dialog box is destroyed when the user responds.
		dialog.signal_connect('response') { |elt,rep|
			if @indiceTypeJeu != 1
				supprimerFichier( @pseudo+"_"+recupNom(@cheminMap) )
			end
			dialog.destroy
			@save_flag = false;
			@window.destroy
		 }
		res = "Bravo, vous avez fait un temps de #{@time/60}min et #{@time%60} s"  #####QUOI FAIRE EN CAS DE VICTOIRE

		dialog.child.add(Gtk::Label.new(res))
		dialog.show_all
	end

	##
	#Enregistre le score de la victoire dans le top 10 du scoreboard
	def enregistreScore()
		chemin = "../scoreboard/"+@cheminMap.split("/")[2]
		monFichier = File.open(chemin)
		#Récupération des scores déjà exists
		allScores = []
		monFichier.each_line{ |ligne|
			allScores.push(ligne.to_s)
		}
		#Suppression de ce qu'il y a dedans
		monFichier = File.open(chemin, "w")
		File.truncate(chemin,0)
		#Réecriture de tous les scores triés dans le fichier
		if allScores.length == 0
			monFichier.write(@pseudo+"-"+recupNom(@cheminMap)+"-"+@time.to_s+"\n")
		else
			allScores.push(@pseudo+"-"+recupNom(@cheminMap)+"-"+@time.to_s+"\n")
			allScores = triScore(allScores)
			allScores = coupeTabMaxElt(allScores,10)
			allScores.each{ |ligne|
				monFichier.write(ligne)
			}
		end
		monFichier.close
	end

	##
	#Méthode de tri bulle pour trier le tableau dans l'ordre croissant en fonction des scores
	def triScore(unTab)
		trier = false
		taille = unTab.length
		while !trier do
			trier = true
			i=0
			while i < taille-1 do
				if unTab[i].split("-")[2].to_i > unTab[i+1].split("-")[2].to_i
					temp = unTab[i]
					unTab[i] = unTab[i+1]
					unTab[i+1] = temp
					trier = false
				end
				i+=1
			end
			taille-=1
		end
		return unTab
	end

	##
	#Méthode qui coupe un tableau à partir du nombre maximum d'élement souhaité
	def coupeTabMaxElt(unTab,unMax)
		while unTab.length > unMax do
			unTab.pop
		end
		return unTab
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
          changeImage(@buttonTab[x][y],@tabCase[@nbHypo])
          @map.putAt!(x,y,Case.create(1))
          @map.accessAt(x,y).color=@nbHypo
          #print "Color sur le press #{@map.accessAt(x,y).color}\n"
       	else
          @map.putAt!(x,y,Case.create(0))
          changeImage(@buttonTab[x][y],"../images/cases/blanc.png")
       	end
        @timePress[x][y]+=1

        if @map.compare
					victoire()
        end
      end
      if button.button==3
				if @map.accessAt(x,y).value != 2
	        changeImage(@buttonTab[x][y],"../images/cases/croix.png")
	        @map.putAt!(x,y,Case.create(2))
	        @timePress[x][y]= 0
				else
					changeImage(@buttonTab[x][y],"../images/cases/blanc.png")
				 	@map.putAt!(x,y,Case.create(0))
				 	@timePress[x][y]= 0
			 end
      end
    else
      indice = IndiceFort.create(@map,x,y)
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

  def onLeave(x,y,button)
    if (@map.accessAt(x,y).value == 1)
    #  print "color =#{@map.accessAt(x,y).color}\n"
      if @map.accessAt(x,y).color != nil
        if (@map.accessAt(x,y).color == @nbHypo + 1)
          @timePress[x][y] = 1
          @map.accessAt(x,y).color = @nbHypo
        end
				surlignageLigneColonne(0,x,y)
        changeImage(@buttonTab[x][y],@tabCase[@map.accessAt(x,y).color])
      else
        changeImage(@buttonTab[x][y],"../images/cases/blanc.png" )
        @timePress[x][y] = 0
      end
    elsif @map.accessAt(x,y).value == 2
			surlignageLigneColonne(0,x,y)
      changeImage(@buttonTab[x][y],"../images/cases/croix.png" )
      @timePress[x][y] = 0
    else
      ajoutLimitation(x,y)
			surlignageLigneColonne(0,x,y)
    end
  end

	def surlignageLigneColonne(indice,x,y)
		if indice == 0
			i=x-1
			while i >= 0 do
				if(@map.accessAt(i,y).value == 0)
					ajoutLimitation(i,y)
				end
				i-=1
			end
			i=y-1
			while i >= 0 do
				if(@map.accessAt(x,i).value == 0)
					ajoutLimitation(x,i)
				end
				i-=1
			end
		else
			i=x-1
			while i >= 0 do
				if(@map.accessAt(i,y).value == 0)
					ajoutLimitationOver(i,y)
				end
				i-=1
			end
			i=y-1
			while i >= 0 do
				if(@map.accessAt(x,i).value == 0)
					ajoutLimitationOver(x,i)
				end
				i-=1
			end
		end
	end

  def aide1()
    indice = IndiceFaible.create(@map)
    dialog = Gtk::Dialog.new("Aide1",
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

  def aide2()
    indice = IndiceMoyen.create(@map)
    res = indice.envoyerIndice.indice.split("-")

    x=res[0].to_i
    y=res[1].to_i
    puts "Res de 2 #{res[2]}"
    if res[2]=="0"
      @map.putAt!(x,y,Case.create(2))
      puts "Case blanche"
      changeImage(@buttonTab[x][y],"../images/cases/croix.png")
    else
      @map.putAt!(x,y,Case.create(1))
      @map.accessAt(x,y).color=1;
      changeImage(@buttonTab[x][y],"../images/cases/noir.png")
    end
    @timePress[x][y]+=1
    @timer.add(60)
    if @map.compare
      victoire()
    end
  end

  def aide3()

    @indiceFortFlag = TRUE
    @timer.add(120)
  end

  ##
  # Crée le timer
  #
  # Retour : Le timer créé
  def initTimer()
    @timer = Timers.new(@inc,@start){
      @time=@timer.time
      if @time > 0
        @temps.set_markup("<span foreground='white' weight=\"bold\" size=\"large\" > #{@time} </span>")
      else
        @temps.set_markup("<span foreground='white' weight=\"bold\" size=\"large\" > Time's up </span>")
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
    topnumbers = Gtk::Box.new(:horizontal,8)
    topnumbers.homogeneous=(TRUE)
########################################################################################################

      for tab in top
        tab.length.upto(maxlen) do
          @temp << "\n"
        end
        if tab == []
          @temp[maxlen]="0"
        else
          0.upto(tab.length()-1) do |i|
              if tab[i]<10
                @temp << "#{tab[i]}    \n"
              else
                @temp << "#{tab[i]}\n"
              end
          end
        end
        label = Gtk::Label.new(@temp.join)
        label = label.set_markup("<span foreground='white' >#{@temp.join}</span>")
        @temp.clear
        topnumbers.add(label)

      end
      wintop = Gtk::Box.new(:horizontal,100)
      print "#{@maxlens}"
      splitHorizontal.add(Gtk::Label.new("__"*(@maxlens+2)))
      splitHorizontal.add(topnumbers)
      wintop.add(splitHorizontal)
      #wintop.add(Gtk::Label.new("   "*@maxlens))
  end

  ##
  # Boite contenant les boutons
  #
  # Retour : la boite crée et initialisée
  def initBoxAide()
    boxAide = Gtk::Box.new(:vertical,30)
    boxAide.add(Gtk::Label.new())

		iAide1 = Gtk::Image.new(:file => "../images/boutons/aide1.png")
		@bAide1 = Gtk::EventBox.new.add(iAide1)
		@bAide1.signal_connect("enter_notify_event"){
			changeImage(@bAide1,"../images/boutons/aide1Over.png")
			@vb.add(Gtk::Label.new.set_markup("<span foreground='white'>Aide qui vous indique la colonne qui a le plus gros chiffre</span>"))
			@window.show_all
		}
		@bAide1.signal_connect("leave_notify_event"){
			changeImage(@bAide1,"../images/boutons/aide1.png")
			@vb.remove(@vb.children.last)
			@window.show_all
		}
    @bAide1.signal_connect("button_press_event") do
      aide1()
    end
    boxAide.add(@bAide1)

		iAide2 = Gtk::Image.new(:file => "../images/boutons/aide120.png")
		@bAide2 = Gtk::EventBox.new.add(iAide2)
		@bAide2.signal_connect("enter_notify_event"){
			changeImage(@bAide2,"../images/boutons/aide120Over.png")
			@vb.add(Gtk::Label.new.set_markup("<span foreground='white'>Aide qui vous revele une case au hasard</span>"))
			@window.show_all
		}
		@bAide2.signal_connect("leave_notify_event"){
			changeImage(@bAide2,"../images/boutons/aide120.png")
			@vb.remove(@vb.children.last)
			@window.show_all
		}
    @bAide2.signal_connect("button_press_event") do
      aide2()
    end
    boxAide.add(@bAide2)

		iAide3 = Gtk::Image.new(:file => "../images/boutons/aide120.png")
		@bAide3 = Gtk::EventBox.new.add(iAide3)
		@bAide3.signal_connect("enter_notify_event"){
			changeImage(@bAide3,"../images/boutons/aide120Over.png")
			@vb.add(Gtk::Label.new.set_markup("<span foreground='white'>Aide vous permettant d'appuyer sur une case et savoir si elle est coloriee ou non</span>"))
			@window.show_all
		}
		@bAide3.signal_connect("leave_notify_event"){
			changeImage(@bAide3,"../images/boutons/aide120.png")
			@vb.remove(@vb.children.last)
			@window.show_all
		}
    @bAide3.signal_connect("button_press_event") do
      aide3()
    end
    boxAide.add(@bAide3)

    return boxAide

  end

	##
  # Boite contenant les boutons
  #
  # Retour : la boite crée et initialisée
  def initBoxHypo()
    boxHypo = Gtk::Box.new(:vertical,30)
    boxHypo.add(Gtk::Label.new())

		#Création du boutton Faire hypothese
		iFaireHypo = Gtk::Image.new(:file => @tabFaireHypo[@nbHypo])
		@bFaireHypo = Gtk::EventBox.new.add(iFaireHypo)
		@bFaireHypo.signal_connect("enter_notify_event"){
			changeImage(@bFaireHypo,@tabFaireHypoOver[@nbHypo])
		}
		@bFaireHypo.signal_connect("leave_notify_event"){
			changeImage(@bFaireHypo,@tabFaireHypo[@nbHypo])
		}
		@bFaireHypo.signal_connect("button_press_event") do
			if @nbHypo < 3
				@nbHypo += 1
				changeBoutonHypo()
				@map = @hypo.faireHypothese()
			end
		end
		boxHypo.add(@bFaireHypo)

		#Création du boutton Valider hypothese
		iValiderHypo = Gtk::Image.new(:file => @tabValiderHypo[@nbHypo])
		@bValiderHypo = Gtk::EventBox.new.add(iValiderHypo)
		@bValiderHypo.signal_connect("enter_notify_event"){
			changeImage(@bValiderHypo,@tabValiderHypoOver[@nbHypo])
		}
		@bValiderHypo.signal_connect("leave_notify_event"){
			changeImage(@bValiderHypo,@tabValiderHypo[@nbHypo])
		}
		@bValiderHypo.signal_connect("button_press_event") do
			if @nbHypo > 0
				@nbHypo -= 1
				changeBoutonHypo()
				@map = @hypo.validerHypothese()
	      actuMap()
			end
		end
		boxHypo.add(@bValiderHypo)

		#Création du boutton Rejeter hypothese
		iRejeterHypo = Gtk::Image.new(:file => @tabRejeterHypo[@nbHypo])
		@bRejeterHypo = Gtk::EventBox.new.add(iRejeterHypo)
		@bRejeterHypo.signal_connect("enter_notify_event"){
			changeImage(@bRejeterHypo,@tabRejeterHypoOver[@nbHypo])
		}
		@bRejeterHypo.signal_connect("leave_notify_event"){
			changeImage(@bRejeterHypo,@tabRejeterHypo[@nbHypo])
		}
		@bRejeterHypo.signal_connect("button_press_event") do
			if @nbHypo > 0
				@nbHypo -= 1
				changeBoutonHypo()
				@map = @hypo.rejeterHypothese()
        actuMap()
			end
		end
    boxHypo.add(@bRejeterHypo)

    return boxHypo
  end

	##
	# Méthode qui change les boutons d'hypothese en fonction du n° d'hypothese
	def changeBoutonHypo()
		changeImage(@bFaireHypo,@tabFaireHypo[@nbHypo])

		changeImage(@bValiderHypo,@tabValiderHypo[@nbHypo])

		changeImage(@bRejeterHypo,@tabRejeterHypo[@nbHypo])
	end

	##
  # Crée une box contenant certains boutons
  #
  # Retour : vertical box
	def initBoxBoutons()
		boxBoutons = Gtk::Box.new(:vertical,30)
    boxBoutons.add(Gtk::Label.new())

		#Création du boutton RESET
		iReset = Gtk::Image.new(:file => "../images/boutons/reset.png")
		@bReset = Gtk::EventBox.new.add(iReset)
		@bReset.signal_connect("enter_notify_event"){
			changeImage(@bReset,"../images/boutons/resetOver.png")
		}
		@bReset.signal_connect("leave_notify_event"){
			changeImage(@bReset,"../images/boutons/reset.png")
		}
		@bReset.signal_connect("button_press_event") do
			@map = Map.create(@cheminMap)
			@nbHypo = 0
      actuMap()
			changeBoutonHypo()
		end
    boxBoutons.add(@bReset)

		#Création du boutton HOME
		iHome = Gtk::Image.new(:file => "../images/boutons/home.png")
		@bHome = Gtk::EventBox.new.add(iHome)
		@bHome.signal_connect("enter_notify_event"){
			changeImage(@bHome,"../images/boutons/homeOver.png")
		}
		@bHome.signal_connect("leave_notify_event"){
			changeImage(@bHome,"../images/boutons/home.png")
		}
		@bHome.signal_connect("button_press_event") do
			@window.destroy
		end
    boxBoutons.add(@bHome)
	end

  ##
  # Crée la grille en format gtk
  #
  # Retour : grille de bouton
  def initGrid()
    @buttonTab = Array.new{Array.new}
    i=0

    grid = Gtk::Box.new(:vertical,2)
    grid.set_homogeneous(TRUE)
    0.upto(@map.rows-1) do |x|
      row = Gtk::Box.new(:horizontal,2)
      row.set_homogeneous(TRUE)
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
            onLeave(x,y,Gtk.current_event)
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
              changeImage(@buttonTab[x][y],@tabCase[@map.accessAt(x,y).color])
          else
              changeImage(@buttonTab[x][y],"../images/cases/blanc.png" )
              @timePress[x][y] = 0
          end
        elsif @map.accessAt(x,y).value == 2
          changeImage(@buttonTab[x][y],"../images/cases/croix.png" )
          @timePress[x][y] = 0

        else
         ajoutLimitation(x,y)

        end

      end

    end
  end

	##
	# Supprimer un fichier de sauvegarde
	#
	# Param : le nom du fichier
	def supprimerFichier(unNom)
		if File.exist?("../sauvegardes/#{unNom}") then
			File.delete("../sauvegardes/#{unNom}")
		end
	end

	##
	# Sauvegarde la partie
	#
	# Param : identificateurs d'une partie
	def sauvegarder(unNom)
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
		monFichier.write(@time)
		monFichier.write("\n***\n")
		monFichier.write(@cheminMap)
		monFichier.write("\n***\n")
		monFichier.write(@nbHypo)
		monFichier.write("\n***\n")

		# Fermeture du fichier
		monFichier.close
	end

	##
	# Change l'image d'un bouton
	def changeImage(unBouton,file)
		unBouton.remove(unBouton.child)
		unBouton.child = (Gtk::Image.new(:file => file ))
		unBouton.show_all
	end

  def ajoutLimitation(x,y)
  	if((x+1)%5 == 0 && (y+1)%5 != 0 && (x != @map.rows - 1))
			changeImage(@buttonTab[x][y],"../images/cases/blancCase5.png")
      @timePress[x][y] = 0
    elsif((x+1)%5 != 0 && (y+1)%5 == 0  && (y != @map.cols - 1))
      changeImage(@buttonTab[x][y],"../images/cases/blancCase5verticale.png" )
      @timePress[x][y] = 0
    elsif((x+1)%5 == 0 && (y+1)%5 == 0 && (x != @map.rows - 1) && (y != @map.cols - 1))
      changeImage(@buttonTab[x][y],"../images/cases/blancCase5_5.png" )
      @timePress[x][y] = 0
    elsif(x == @map.rows - 1 && (y+1)%5 == 0 && y != @map.cols - 1)
    changeImage(@buttonTab[x][y],"../images/cases/blancCase5verticale.png" )
      @timePress[x][y] = 0
    elsif(y == @map.cols - 1 && (x+1)%5 == 0 && x != @map.rows - 1)
      changeImage(@buttonTab[x][y],"../images/cases/blancCase5.png" )
      @timePress[x][y] = 0
    else
      changeImage(@buttonTab[x][y],"../images/cases/blanc.png" )
  @timePress[x][y] = 0
    end
  end

	def ajoutLimitationOver(x,y)
	  if((x+1)%5 == 0 && (y+1)%5 != 0 && (x != @map.rows - 1))
	    changeImage(@buttonTab[x][y],"../images/cases/blancOver5h.png" )
	    @timePress[x][y] = 0
	  elsif((x+1)%5 != 0 && (y+1)%5 == 0  && (y != @map.cols - 1))
	    changeImage(@buttonTab[x][y],"../images/cases/blancOver5v.png" )
	    @timePress[x][y] = 0
	  elsif((x+1)%5 == 0 && (y+1)%5 == 0 && (x != @map.rows - 1) && (y != @map.cols - 1))
	    changeImage(@buttonTab[x][y],"../images/cases/blancOver5_5.png" )
	    @timePress[x][y] = 0
	  elsif(x == @map.rows - 1 && (y+1)%5 == 0 && y != @map.cols - 1)
	    changeImage(@buttonTab[x][y],"../images/cases/blancOver5v.png" )
	    @timePress[x][y] = 0
	  elsif(y == @map.cols - 1 && (x+1)%5 == 0 && x != @map.rows - 1)
	    changeImage(@buttonTab[x][y],"../images/cases/blancOver5h.png" )
	    @timePress[x][y] = 0
	  else
	    changeImage(@buttonTab[x][y],"../images/cases/blancOver.png" )
	    @timePress[x][y] = 0
	  end
	end

end
