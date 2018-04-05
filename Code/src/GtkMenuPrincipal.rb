begin
  require 'rubygems'
 rescue LoadError
end
require 'gtk3'
load "GtkMap.rb"
load "GtkMenuJouer.rb"
load "GtkMenuCharger.rb"
load "GtkCredits.rb"
load "GtkScoreboardBenj.rb"

class MenuPrincipal < Menu

  def initialize(pseudo)
		super(pseudo)
		lancerFenetre()
  end

	def lancerFenetre()
		puts("Creation fenetre Menu Principal")

    @window = creerWindow()

		grid = Gtk::Grid.new
		hb = Gtk::Box.new(:horizontal, 10)
		vb = Gtk::Box.new(:vertical, 20)

		#Label de bordure gauche
		hb.add(Gtk::Label.new(" "))

		#Label de bordure haut
		vb.add(Gtk::Label.new("\n"))

		#Label du pseudo
		lPseudo = Gtk::Label.new
		lPseudo.set_markup("<big><i><big><b><span foreground='white'>#{@pseudo}</span></b></big></i></big>")
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
				onDestroy()
        MenuJouer.new(@pseudo)
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
		@bCharger.signal_connect("button_press_event") do
				onDestroy()
				MenuCharger.new(@pseudo)
    end
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
		@bScore.signal_connect("button_press_event") do
				onDestroy()
				Scoreboard.new(@pseudo)
    end
		vb.add(@bScore)

    #Création du boutton CREDITS
		iCredits = Gtk::Image.new(:file => "../images/boutons/credits.png")
    @bCredits = Gtk::EventBox.new.add(iCredits)
		@bCredits.signal_connect("enter_notify_event"){
			onEnter(@bCredits)
		}
    @bCredits.signal_connect("button_press_event"){
			Credits.new()
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
		hb.add(Gtk::Label.new("\t\t\t\t\t\t\t"))

		#Partie droite
		vb2 = Gtk::Box.new(:vertical,0)
		vb2.add(Gtk::Label.new("\n\n\n\n\n\n\n\n\n\n\n\n\n\n"))
		@iIllustrative = Gtk::Image.new(:file => "../images/illustrations/nothing.png")
		vb2.add(@iIllustrative)
		hb.add(vb2)

		grid.attach(hb,0,0,1,1)

		#Wallpaper
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
		if button == @bNew
			button.remove(button.child)
			button.child = Gtk::Image.new(:file => "../images/boutons/newOver.png")
			@iIllustrative.set_from_file("../images/illustrations/new.png")
			button.show_all
		elsif button == @bCharger
			button.remove(button.child)
			button.child = Gtk::Image.new(:file => "../images/boutons/chargerOver.png")
			@iIllustrative.set_from_file("../images/illustrations/load.png")
			button.show_all
		elsif button == @bScore
			button.remove(button.child)
			button.child = Gtk::Image.new(:file => "../images/boutons/scoreboardOver.png")
			@iIllustrative.set_from_file("../images/illustrations/score.png")
			button.show_all
		elsif button == @bCredits
			button.remove(button.child)
			button.child = Gtk::Image.new(:file => "../images/boutons/creditsOver.png")
			@iIllustrative.set_from_file("../images/illustrations/credits.png")
			button.show_all
		else button == @bQuitter
			button.remove(button.child)
			button.child = Gtk::Image.new(:file => "../images/boutons/quitterOver.png")
			@iIllustrative.set_from_file("../images/illustrations/quitter.png")
			button.show_all
		end
	end

	def onLeave(button)
		if button == @bNew
			button.remove(button.child)
			button.child = Gtk::Image.new(:file => "../images/boutons/new.png")
			putNothing
			button.show_all
		elsif button == @bCharger
			button.remove(button.child)
			button.child = Gtk::Image.new(:file => "../images/boutons/charger.png")
			putNothing
			button.show_all
		elsif button == @bScore
			button.remove(button.child)
			button.child = Gtk::Image.new(:file => "../images/boutons/scoreboard.png")
			putNothing
			button.show_all
		elsif button == @bCredits
			button.remove(button.child)
			button.child = Gtk::Image.new(:file => "../images/boutons/credits.png")
			putNothing
			button.show_all
		else button == @bQuitter
			button.remove(button.child)
			button.child = Gtk::Image.new(:file => "../images/boutons/quitter.png")
			putNothing
			button.show_all
		end
	end

end
