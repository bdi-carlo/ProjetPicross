begin
  require 'rubygems'
 rescue LoadError
end
require 'gtk3'
require "date"
load 'GtkMap.rb'


class GtkDidacticiel < GtkMap

	#@verifcase
	#@verifcroix
	#@verifhypo
	#@verifaide

	attr_accessor :verifcase,:verifcroix,:verifhypo,:verifaide
	
	
  def initialize()
	super(charge, pseudo, cheminMap, inc, start, map, hypo, nbHypo)

	@verifcase = 0
	@verifcroix = 0
	@verifhypo  = 0
	@verifaide = 0

	map = Gui.new("./grilles/didacticiel/grilleE.rb",1,0)

	Didacticiel()
	initDialogue()
	affichemessage()
	
  end
	
  def affichemessage 
	#actualise le texte de la variable message
	changerMessage()
	initDialogue()
	
  end

  def initDialogue()
  	##### création de la boite de dialogue ou va etre affiché les instructions
	dialogue = Gtk::Dialog.new("message",$main_application_window, Gtk::Dialog::DESTROY_WITH_PARENT,[ Gtk::Stock::OK, Gtk::Dialog::RESPONSE_NONE ])
	dialogue.set_window_position(:center_always)
	dialogue.child.add(Gtk::Label.new( "\n"+@message+"\n" ))

	dialog.signal_connect('response') { dialog.destroy }
	##### LE MESSAGE A AFFICHER
	res = "#{@message}"  

    dialog.child.add(Gtk::Label.new(res))
	dialogue.show_all

	
  end

  def onEnter(x,y,button)
    Gdk.pointer_ungrab(Gdk::CURRENT_TIME)
    @buttonTab[x][y].set_focus(TRUE)

    if button.state.button1_mask?
      if @timePress[x][y]%2 == 0

        @buttonTab[x][y].remove(@buttonTab[x][y].child)
        @buttonTab[x][y].child = (Gtk::Image.new(:file => @tabCase[@nbHypo]))
############################################################################################
		if(@etape == 1 && @verifcase == 0)
			@verifcase += 1
			#etape du didacticiel
			@etape += 1
			affichemessage()
		end
############################################################################################
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
      if @map.compare                      #####QUOI FAIRE EN CAS DE VICTOIRE
				@timer.pause
        dialog = Gtk::Dialog.new("Bravo",
                                 $main_application_window,
                                 Gtk::DialogFlags::DESTROY_WITH_PARENT,
                                 [ Gtk::Stock::OK, Gtk::ResponseType::NONE ])

        # Ensure that the dialog box is destroyed when the user responds.
        dialog.signal_connect('response') {
					supprimerFichier( @pseudo+"_"+recupNom(@cheminMap) )
					Gtk.main_quit
          puts "Fermeture picross sur victoire"
          dialog.destroy
         }
        res = "Bravo, vous avez fait un temps de #{@time} s"  #####QUOI FAIRE EN CAS DE VICTOIRE

        dialog.child.add(Gtk::Label.new(res))
        dialog.show_all


      end
    elsif button.state.button3_mask?
      @buttonTab[x][y].remove(@buttonTab[x][y].child)
      @buttonTab[x][y].child = (Gtk::Image.new(:file =>"../images/cases/croix.png"))
############################################################################################	  
	  if(@etape == 2 && @verifcroix == 0)
			@verifcroix += 1
			#etape du didacticiel
			@etape += 1
			affichemessage()
	  end
############################################################################################
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
                                   Gtk::DialogFlags::DESTROY_WITH_PARENT,
                                   [ Gtk::Stock::OK, Gtk::ResponseType::NONE ])

          # Ensure that the dialog box is destroyed when the user responds.
          dialog.signal_connect('response') {
						supprimerFichier( @pseudo+"_"+recupNom(@cheminMap) )
						Gtk.main_quit
						puts "Fermeture picross sur victoire"
            dialog.destroy
          }
          res = "Bravo, vous avez fait un temps de #{@time} s"  #####QUOI FAIRE EN CAS DE VICTOIRE

          dialog.child.add(Gtk::Label.new(res))
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
			@bFaireHypo.remove(@bFaireHypo.child)
			@bFaireHypo.child = Gtk::Image.new(:file => @tabFaireHypoOver[@nbHypo])
			@bFaireHypo.show_all
		}
		@bFaireHypo.signal_connect("leave_notify_event"){
			@bFaireHypo.remove(@bFaireHypo.child)
			@bFaireHypo.child = Gtk::Image.new(:file => @tabFaireHypo[@nbHypo])
			@bFaireHypo.show_all
		}
		@bFaireHypo.signal_connect("button_press_event") do
			if @nbHypo < 3
############################################################################################
				if(@etape == 4 && @verifhypo == 0)
					@verifhypo += 1
					#etape du didacticiel
					@etape += 1
					affichemessage()
				end
############################################################################################
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
			@bValiderHypo.remove(@bValiderHypo.child)
			@bValiderHypo.child = Gtk::Image.new(:file => @tabValiderHypoOver[@nbHypo])
			@bValiderHypo.show_all
		}
		@bValiderHypo.signal_connect("leave_notify_event"){
			@bValiderHypo.remove(@bValiderHypo.child)
			@bValiderHypo.child = Gtk::Image.new(:file => @tabValiderHypo[@nbHypo])
			@bValiderHypo.show_all
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
			@bRejeterHypo.remove(@bRejeterHypo.child)
			@bRejeterHypo.child = Gtk::Image.new(:file => @tabRejeterHypoOver[@nbHypo])
			@bRejeterHypo.show_all
		}
		@bRejeterHypo.signal_connect("leave_notify_event"){
			@bRejeterHypo.remove(@bRejeterHypo.child)
			@bRejeterHypo.child = Gtk::Image.new(:file => @tabRejeterHypo[@nbHypo])
			@bRejeterHypo.show_all
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
			@bAide1.remove(@bAide1.child)
			@bAide1.child = Gtk::Image.new(:file => "../images/boutons/aide1Over.png")
			@bAide1.show_all
		}
		@bAide1.signal_connect("leave_notify_event"){
			@bAide1.remove(@bAide1.child)
			@bAide1.child = Gtk::Image.new(:file => "../images/boutons/aide1.png")
			@bAide1.show_all
		}
    @bAide1.signal_connect("button_press_event") do
############################################################################################
		if(@etape == 3 && @verifaide == 0)
				@verifaide += 1
				#etape du didacticiel
				@etape += 1
				affichemessage()

		end
############################################################################################
    	aide1()
    end
    boxAide.add(@bAide1)

		iAide2 = Gtk::Image.new(:file => "../images/boutons/aide2.png")
		@bAide2 = Gtk::EventBox.new.add(iAide2)
		@bAide2.signal_connect("enter_notify_event"){
			@bAide2.remove(@bAide2.child)
			@bAide2.child = Gtk::Image.new(:file => "../images/boutons/aide2Over.png")
			@bAide2.show_all
		}
		@bAide2.signal_connect("leave_notify_event"){
			@bAide2.remove(@bAide2.child)
			@bAide2.child = Gtk::Image.new(:file => "../images/boutons/aide2.png")
			@bAide2.show_all
		}
    @bAide2.signal_connect("button_press_event") do
############################################################################################
		if(@etape == 3 && @verifaide == 0)
				@verifaide += 1
				#etape du didacticiel
				@etape += 1
				affichemessage()

		end
############################################################################################	
      aide2()
    end
    boxAide.add(@bAide2)

		iAide3 = Gtk::Image.new(:file => "../images/boutons/aide3.png")
		@bAide3 = Gtk::EventBox.new.add(iAide3)
		@bAide3.signal_connect("enter_notify_event"){
			@bAide3.remove(@bAide3.child)
			@bAide3.child = Gtk::Image.new(:file => "../images/boutons/aide3Over.png")
			@bAide3.show_all
		}
		@bAide3.signal_connect("leave_notify_event"){
			@bAide3.remove(@bAide3.child)
			@bAide3.child = Gtk::Image.new(:file => "../images/boutons/aide3.png")
			@bAide3.show_all
		}
    @bAide3.signal_connect("button_press_event") do
############################################################################################
		if(@etape == 3 && @verifaide == 0)
				@verifaide += 1
				#etape du didacticiel
				@etape += 1
				affichemessage()

		end
############################################################################################
      aide3()
    end
    boxAide.add(@bAide3)

    return boxAide

  end

  
end