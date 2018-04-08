begin
  require 'rubygems'
 rescue LoadError
end
require 'gtk3'
require "date"
load 'GtkMap.rb'
load 'Didacticiel.rb'


class GtkDidacticiel < Gui

	#@verifcase
	#@verifcroix
	#@verifhypo
	#@verifaide

	attr_accessor :verifcase,:verifcroix,:verifhypo,:verifaide


  def initialize(indiceTypeJeu, charge, pseudo, cheminMap, inc, start, map, hypo, nbHypo)

	@verifcase = 0
	@verifcroix = 0
	@verifhypo  = 0
	@verifaide = 0
	puts "Coucou"
	@dida = Didacticiel.new()
	initDialogue()
	@dida.etape += 1
	affichemessage()
	super(indiceTypeJeu, charge, pseudo, cheminMap, inc, start, map, hypo, nbHypo)
  end
	##
  # Actualise le texte de la variable message
  def affichemessage

	@dida.changerMessage()
	initDialogue()

  end
  ##
  # Création de la boite de dialogue ou va etre affiché les instructions
  def initDialogue()

	dialog = Gtk::Dialog.new("message",$main_application_window, Gtk::Dialog::DESTROY_WITH_PARENT,[ Gtk::Stock::OK, Gtk::Dialog::RESPONSE_NONE ])
	dialog.set_window_position(:center_always)
	#dialogue.child.add(Gtk::Label.new( "\n"+@message+"\n" ))

	dialog.signal_connect('response') { dialog.destroy }
	##### LE MESSAGE A AFFICHER
	res = @dida.message

   	dialog.child.add(Gtk::Label.new(res))
	dialog.show_all


  end
  ##
  # MouseOver pour la grille 
  def onEnter(x,y,button)
    Gdk.pointer_ungrab(Gdk::CURRENT_TIME)
    @buttonTab[x][y].set_focus(TRUE)

    if button.state.button1_mask?
      if @timePress[x][y]%2 == 0
        changeImage(@buttonTab[x][y],@tabCase[@nbHypo])

       @map.putAt!(x,y,Case.create(1))
############################################################################################
		if(@dida.etape == 1 && @verifcase == 0)
			@verifcase += 1
			#etape du didacticiel
			@dida.etape += 1
			affichemessage()
		end
############################################################################################

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


end
