begin
  require 'rubygems'
 rescue LoadError
end
require 'gtk3'
load "GtkMap.rb"
load "GtkMenuJouer.rb"

class MenuPrincipal

    def initialize(game)
		@jeu = game

	    puts("Creation fenetre Main")

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

			#Création du bouton NEW PARTIE
			iNew = Gtk::Image.new(:file => "../images/boutons/new.png")
	        @bNew = Gtk::EventBox.new.add(iNew)
			@bNew.signal_connect("enter_notify_event"){
				onEnter(@bNew)
			}
			@bNew.signal_connect("leave_notify_event"){
				onLeave(@bNew)
			}
			#Lorsque l'on clique sur le bouton
			@bNew.signal_connect("button_press_event") do
	        @window.hide
	        MenuJouer.new()
	        @window.show_all
	    end
			vb.add(@bNew)

			#Création du boutton CHARGER
			iCharger = Gtk::Image.new(:file => "../images/boutons/charger.png")
	    @bCharger = Gtk::EventBox.new.add(iCharger)
			@bCharger.signal_connect("enter_notify_event"){
				onEnter(@bCharger)
			}
			@bCharger.signal_connect("leave_notify_event"){
				onLeave(@bCharger)
			}
			vb.add(@bCharger)

			#Création du boutton SCOREBOARD
			iScore = Gtk::Image.new(:file => "../images/boutons/scoreboard.png")
	    @bScore = Gtk::EventBox.new.add(iScore)
			@bScore.signal_connect("enter_notify_event"){
				onEnter(@bScore)
			}
			@bScore.signal_connect("leave_notify_event"){
				onLeave(@bScore)
			}
			vb.add(@bScore)

	    #Création du boutton CREDITS
			iCredits = Gtk::Image.new(:file => "../images/boutons/credits.png")
	    @bCredits = Gtk::EventBox.new.add(iCredits)
			@bCredits.signal_connect("enter_notify_event"){
				onEnter(@bCredits)
			}
			@bCredits.signal_connect("leave_notify_event"){
				onLeave(@bCredits)
			}
			vb.add(@bCredits)

	    #Création du boutton QUITTER
			iQuitter = Gtk::Image.new(:file => "../images/boutons/quitter.png")
	    @bQuitter = Gtk::EventBox.new.add(iQuitter)
			@bQuitter.signal_connect("enter_notify_event"){
				onEnter(@bQuitter)
			}
			@bQuitter.signal_connect("leave_notify_event"){
				onLeave(@bQuitter)
			}
			@bQuitter.signal_connect("button_press_event") do
				onDestroy()
			end
			vb.add(@bQuitter)

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
			if button == @bNew
				button.remove(button.child)
				button.child = Gtk::Image.new(:file => "../images/boutons/newOver.png")
				button.show_all
			elsif button == @bCharger
				button.remove(button.child)
				button.child = Gtk::Image.new(:file => "../images/boutons/chargerOver.png")
				button.show_all
			elsif button == @bScore
				button.remove(button.child)
				button.child = Gtk::Image.new(:file => "../images/boutons/scoreboardOver.png")
				button.show_all
			elsif button == @bCredits
				button.remove(button.child)
				button.child = Gtk::Image.new(:file => "../images/boutons/creditsOver.png")
				button.show_all
			else button == @bQuitter
				button.remove(button.child)
				button.child = Gtk::Image.new(:file => "../images/boutons/quitterOver.png")
				button.show_all
			end
		end

		def onLeave(button)
			if button == @bNew
				button.remove(button.child)
				button.child = Gtk::Image.new(:file => "../images/boutons/new.png")
				button.show_all
			elsif button == @bCharger
				button.remove(button.child)
				button.child = Gtk::Image.new(:file => "../images/boutons/charger.png")
				button.show_all
			elsif button == @bScore
				button.remove(button.child)
				button.child = Gtk::Image.new(:file => "../images/boutons/scoreboard.png")
				button.show_all
			elsif button == @bCredits
				button.remove(button.child)
				button.child = Gtk::Image.new(:file => "../images/boutons/credits.png")
				button.show_all
			else button == @bQuitter
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
