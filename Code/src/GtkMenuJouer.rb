begin
  require 'rubygems'
 rescue LoadError
end
require 'gtk3'

load "GtkMap.rb"
load "Aventure.rb"
load "Menu.rb"
load "GtkMenuChoixGrille.rb"
load "GtkDidacticiel.rb"

class MenuJouer < Menu

  def initialize(pseudo)
		super(pseudo)
		lancerFenetre()
	end

	def lancerFenetre()
    puts("Creation fenetre Jouer")

		@window = creerWindow()

		grid = Gtk::Grid.new
		hb = Gtk::Box.new(:horizontal, 10)
		vb = Gtk::Box.new(:vertical, 20)

		#Label de bordure
		hb.add(Gtk::Label.new(" "))

		#Label de bordure
		vb.add(Gtk::Label.new("\n"))

		#Label du pseudo
		lPseudo = Gtk::Label.new
		lPseudo.set_markup("<big><i><big><b><span foreground='white'>#{@pseudo}</span></b></big></i></big>")
		#lPseudo.wrap = true
		vb.add(lPseudo)

		#Label d'espacement
		vb.add(Gtk::Label.new("\n\n\n"))

		#Création du bouton AVENTURE
		iAventure = Gtk::Image.new(:file => "../images/boutons/aventure.png")
				@bAventure = Gtk::EventBox.new.add(iAventure)
		@bAventure.signal_connect("enter_notify_event"){
			onEnter(@bAventure)
		}
		@bAventure.signal_connect("leave_notify_event"){
			onLeave(@bAventure)
		}
		#Lorsque l'on clique sur le bouton
		@bAventure.signal_connect("button_press_event") do
			
      @window.destroy
      Aventure.new(@pseudo)
		end
		vb.add(@bAventure)

		#Création du boutton COMPETITION
		iCompetition = Gtk::Image.new(:file => "../images/boutons/competition.png")
		@bCompetition = Gtk::EventBox.new.add(iCompetition)
		@bCompetition.signal_connect("enter_notify_event"){
			onEnter(@bCompetition)
		}
		@bCompetition.signal_connect("leave_notify_event"){
			onLeave(@bCompetition)
		}
		@bCompetition.signal_connect("button_press_event") do
			onDestroy()
      			MenuChoixGrille.new(@pseudo,1)
		end
		vb.add(@bCompetition)

		#Création du boutton NORMAL
		iNormal = Gtk::Image.new(:file => "../images/boutons/normal.png")
		@bNormal = Gtk::EventBox.new.add(iNormal)
		@bNormal.signal_connect("enter_notify_event"){
			onEnter(@bNormal)
		}
		@bNormal.signal_connect("leave_notify_event"){
			onLeave(@bNormal)
		}
		@bNormal.signal_connect("button_press_event") do
			onDestroy()
			MenuChoixGrille.new(@pseudo,0)
		end
		vb.add(@bNormal)

		#Création du boutton DIDACTICIEL
		iDidacticiel = Gtk::Image.new(:file => "../images/boutons/didacticiel.png")
		@bDidacticiel = Gtk::EventBox.new.add(iDidacticiel)
		@bDidacticiel.signal_connect("enter_notify_event"){
			onEnter(@bDidacticiel)
		}
		@bDidacticiel.signal_connect("leave_notify_event"){
			onLeave(@bDidacticiel)
		}
		@bDidacticiel.signal_connect("button_press_event") do
			onDestroy()
			#indiceTypeJeu, charge, pseudo, cheminMap, inc, start, map, hypo, nbHypo
			GtkDidacticiel.new(nil, 0, @pseudo, "../grilles/facile/10x10/Neuf", 1, 0, nil, nil, nil)	
			
		end
		vb.add(@bDidacticiel)

		#Création du boutton RETOUR
		iRetour = Gtk::Image.new(:file => "../images/boutons/retour.png")
		@bRetour = Gtk::EventBox.new.add(iRetour)
		@bRetour.signal_connect("enter_notify_event"){
			onEnter(@bRetour)
		}
		@bRetour.signal_connect("leave_notify_event"){
			onLeave(@bRetour)
		}
		@bRetour.signal_connect("button_press_event") do
			onDestroy()
			MenuPrincipal.new(@pseudo)
		end
		vb.add(@bRetour)

		hb.add(vb)

		#Label d'espacement
		hb.add(Gtk::Label.new("\t\t\t\t\t\t\t"))

		#Partie droite
		vb2 = Gtk::Box.new(:vertical,0)
		vb2.add(Gtk::Label.new("\n\n\n\n\n\n\n\n\n\n\n\n\n\n"))
		@iIllustrative = Gtk::Image.new(:file => "../images/illustrations/nothing.png")
		vb2.add(@iIllustrative)
		hb.add(vb2)

		grid.attach(hb,0,0,1,1)

		image = Gtk::Image.new(:file => "../images/wallpaper.jpg")
		grid.attach(image,0,0,1,1)

		@window.add(grid)

		@window.show_all

		Gtk.main
	end

	def putNothing()
		@iIllustrative.set_from_file("../images/illustrations/nothing.png")
	end

	def onEnter(button)
		if button == @bAventure
			button.remove(button.child)
			button.child = Gtk::Image.new(:file => "../images/boutons/aventureOver.png")
			@iIllustrative.set_from_file("../images/illustrations/aventure.png")
			button.show_all
		elsif button == @bCompetition
			button.remove(button.child)
			button.child = Gtk::Image.new(:file => "../images/boutons/competitionOver.png")
			@iIllustrative.set_from_file("../images/illustrations/competition.png")
			button.show_all
		elsif button == @bNormal
			button.remove(button.child)
			button.child = Gtk::Image.new(:file => "../images/boutons/normalOver.png")
			@iIllustrative.set_from_file("../images/illustrations/normal.png")
			button.show_all
		elsif button == @bDidacticiel
			button.remove(button.child)
			button.child = Gtk::Image.new(:file => "../images/boutons/didacticielOver.png")
			@iIllustrative.set_from_file("../images/illustrations/apprendre.png")
			button.show_all
		else button == @bRetour
			button.remove(button.child)
			button.child = Gtk::Image.new(:file => "../images/boutons/retourOver.png")
			@iIllustrative.set_from_file("../images/illustrations/retour.png")
			button.show_all
		end
	end

	def onLeave(button)
		if button == @bAventure
			button.remove(button.child)
			button.child = Gtk::Image.new(:file => "../images/boutons/aventure.png")
			putNothing
			button.show_all
		elsif button == @bCompetition
			button.remove(button.child)
			button.child = Gtk::Image.new(:file => "../images/boutons/competition.png")
			putNothing
			button.show_all
		elsif button == @bNormal
			button.remove(button.child)
			button.child = Gtk::Image.new(:file => "../images/boutons/normal.png")
			putNothing
			button.show_all
		elsif button == @bDidacticiel
			button.remove(button.child)
			button.child = Gtk::Image.new(:file => "../images/boutons/didacticiel.png")
			putNothing
			button.show_all
		else button == @bRetour
			button.remove(button.child)
			button.child = Gtk::Image.new(:file => "../images/boutons/retour.png")
			putNothing
			button.show_all
		end
	end

end
