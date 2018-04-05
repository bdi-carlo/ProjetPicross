begin
  require 'rubygems'
 rescue LoadError
end
require 'gtk3'
require "date"
require 'yaml'

load "GtkMap.rb"
load "Menu.rb"

class Scoreboard < Menu

  def initialize(pseudo)
		super(pseudo)
		lancerFenetre()
		@flagScore = false
	end

	def lancerFenetre()
		puts("Creation fenetre Charger")

		@window = creerWindow()

		grid = Gtk::Grid.new
		@hb = Gtk::Box.new(:horizontal, 10)
		vb = Gtk::Box.new(:vertical, 20)

		#Label de bordure
		@hb.add(Gtk::Label.new(" "))

		#Label de bordure
		vb.add(Gtk::Label.new(""))

		#Label du pseudo
		lPseudo = Gtk::Label.new
		lPseudo.set_markup("<big><i><big><b><span foreground='white'>#{@pseudo}</span></b></big></i></big>")
		vb.add(lPseudo)

		#Label d'espacement
		vb.add(Gtk::Label.new("\n"))

		vb.add(Gtk::Label.new.set_markup("<big><big><span foreground='black'>Choix difficulte#{"\n\n"}</span></big></big>"))

		#Radio buttons
		@facile = Gtk::RadioButton.new(:label => "Niveau Facile")
		@facile.child.set_markup("<span foreground='white'>Niveau Facile</span>")
    @moyen = Gtk::RadioButton.new(:member => @facile, :label => "Niveau Moyen")
		@moyen.child.set_markup("<span foreground='white'>Niveau Moyen</span>")
    @difficile = Gtk::RadioButton.new(:member => @facile, :label => "Niveau Difficile")
		@difficile.child.set_markup("<span foreground='white'>Niveau Difficile</span>")
		vb.add(@facile).add(@moyen).add(@difficile)

		#Création du bouton CONFIRMER
		iConfirmer = Gtk::Image.new(:file => "../images/boutons/confirmer.png")
		@bConfirmer = Gtk::EventBox.new.add(iConfirmer)
		@bConfirmer.signal_connect("enter_notify_event"){
			@bConfirmer.remove(@bConfirmer.child)
			@bConfirmer.child = Gtk::Image.new(:file => "../images/boutons/confirmerOver.png")
			@bConfirmer.show_all
		}
		@bConfirmer.signal_connect("leave_notify_event"){
			@bConfirmer.remove(@bConfirmer.child)
			@bConfirmer.child = Gtk::Image.new(:file => "../images/boutons/confirmer.png")
			@bConfirmer.show_all
		}
		vb.add(@bConfirmer)

		#Création du boutton RETOUR
		iRetour = Gtk::Image.new(:file => "../images/boutons/retour.png")
		@bRetour = Gtk::EventBox.new.add(iRetour)
		@bRetour.signal_connect("enter_notify_event"){
			@bRetour.remove(@bRetour.child)
			@bRetour.child = Gtk::Image.new(:file => "../images/boutons/retourOver.png")
			@bRetour.show_all
		}
		@bRetour.signal_connect("leave_notify_event"){
			@bRetour.remove(@bRetour.child)
			@bRetour.child = Gtk::Image.new(:file => "../images/boutons/retour.png")
			@bRetour.show_all
		}
		@bRetour.signal_connect("button_press_event") do
			onDestroy()
			MenuPrincipal.new(@pseudo)
		end
		vb.add(@bRetour)

		@bConfirmer.signal_connect("button_press_event") do
			#Récupération de la liste des grilles suivant le choix
			if @facile.active?
				afficheScores("facile")
			elsif @moyen.active?
				afficheScores("moyen")
			elsif @difficile.active?
				afficheScores("difficile")
			end
		end

		@hb.add(vb)

		@hb.add(Gtk::Label.new("\t\t\t\t\t\t\t\t"))

		grid.attach(@hb,0,0,1,1)

		image = Gtk::Image.new(:file => "../images/wallpaper.jpg")
		grid.attach(image,0,0,1,1)

		@window.add(grid)

		@window.show_all

		Gtk.main
	end

	##
	# Affiche les scores en fonction de la difficulté
	def afficheScores(difficulte)
		if @flagScore
			@hb.remove(@hb.children.last)
		end
		vb = Gtk::Box.new(:vertical, 5)
		vb.add(Gtk::Label.new.set_markup("<big><big><span foreground='black'>#{"\n\n\n\n\n\n\n\n\n"}Scoreboard#{"\n"}</span></big></big>"))

		chemin = "../scoreboard/"+difficulte
		monFichier = File.open(chemin)
		#Récupération des scores
		allScores = []
		monFichier.each_line{ |ligne|
			allScores.push(ligne.to_s.strip)
		}
		if allScores.length == 0
			vb.add(Gtk::Label.new.set_markup("<big><b><span foreground='white'>Personne n'a enregistre de score</span></b></big>"))
		else
			pos=1
			allScores.each{ |elt|
				tmp = elt.split("-")
				vb.add(Gtk::Label.new.set_markup("<big><b><span foreground='white'>#{pos.to_s + " - " + tmp[0] + "\t\t" + tmp[1] + "\t\t" + tmp[2] + "s"}</span></b></big>"))
				pos+=1
			}
		end
		@flagScore = true
		@hb.add(vb)
		@window.show_all
	end

end
