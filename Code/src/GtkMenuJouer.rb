begin
  require 'rubygems'
 rescue LoadError
end
require 'gtk3'
load "GtkMap.rb"
load "Aventure.rb"

class MenuJouer

  def initialize(game)
		@jeu = game

    puts("Creation fenetre Jouer")

		#Création de la fenêtre
		@window = Gtk::Window.new("Picross")
		#@window.set_size_request(300, 300)
		@window.resizable=FALSE
		@window.set_window_position(:center_always)

		@window.signal_connect('destroy') {onDestroy}

		grid = Gtk::Grid.new
		hb = Gtk::Box.new(:horizontal, 10)
		vb = Gtk::Box.new(:vertical, 20)

		#Label de bordure
		hb.add(Gtk::Label.new(""))

		#Label de bordure
		vb.add(Gtk::Label.new("\n"))

		#Label du pseudo
		lPseudo = Gtk::Label.new
		lPseudo.set_markup("<big><i><big><b><span foreground='white'>#{@jeu.pseudo}</span></b></big></i></big>")
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
      Aventure.new(@jeu.pseudo)
      onDestroy()
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
			@window.destroy
      Gui.new(0, @jeu.pseudo, "../grilles/10x10/Neuf", 1, 0, nil, nil, nil)
      onDestroy()
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
			@window.destroy
			onDestroy()
		end
		vb.add(@bRetour)

		hb.add(vb)

		#Label d'espacement
		hb.add(Gtk::Label.new(""))

		grid.attach(hb,0,0,1,1)

		image = Gtk::Image.new(:file => "../images/wallpaper.jpg")
		grid.attach(image,0,0,1,1)

		@window.add(grid)

		@window.show_all

		Gtk.main

	end

	def onEnter(button)
		if button == @bAventure
			button.remove(button.child)
			button.child = Gtk::Image.new(:file => "../images/boutons/aventure.png")
			button.show_all
		elsif button == @bCompetition
			button.remove(button.child)
			button.child = Gtk::Image.new(:file => "../images/boutons/competition.png")
			button.show_all
		elsif button == @bNormal
			button.remove(button.child)
			button.child = Gtk::Image.new(:file => "../images/boutons/normal.png")
			button.show_all
		elsif button == @bDidacticiel
			button.remove(button.child)
			button.child = Gtk::Image.new(:file => "../images/boutons/didacticiel.png")
			button.show_all
		else button == @bRetour
			button.remove(button.child)
			button.child = Gtk::Image.new(:file => "../images/boutons/retourOver.png")
			button.show_all
		end
	end

	def onLeave(button)
		if button == @bAventure
			button.remove(button.child)
			button.child = Gtk::Image.new(:file => "../images/boutons/aventure.png")
			button.show_all
		elsif button == @bCompetition
			button.remove(button.child)
			button.child = Gtk::Image.new(:file => "../images/boutons/competition.png")
			button.show_all
		elsif button == @bNormal
			button.remove(button.child)
			button.child = Gtk::Image.new(:file => "../images/boutons/normal.png")
			button.show_all
		elsif button == @bDidacticiel
			button.remove(button.child)
			button.child = Gtk::Image.new(:file => "../images/boutons/didacticiel.png")
			button.show_all
		else button == @bRetour
			button.remove(button.child)
			button.child = Gtk::Image.new(:file => "../images/boutons/quitter.png")
			button.show_all
		end
	end

	##
	# Callback de la fermeture de l'appli
	def onDestroy
		puts "Fin de l'application"
		#Quit 'propre'
		Gtk.main_quit
	end

end
