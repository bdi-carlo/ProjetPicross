begin
  require 'rubygems'
 rescue LoadError
end
require 'gtk3'
require "date"
require 'yaml'

load "GtkMap.rb"
load "Menu.rb"

class MenuCharger < Menu

  def initialize(game)
		super(game)
		lancerFenetre()
	end

	def lancerFenetre()
		puts("Creation fenetre Charger")

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
		lPseudo.set_markup("<big><i><big><b><span foreground='white'>#{@jeu.pseudo}</span></b></big></i></big>")
		#lPseudo.wrap = true
		vb.add(lPseudo)

		#Label d'espacement
		vb.add(Gtk::Label.new("\n\n\n"))

		#Récupération de la liste des sauvegardes concercant le pseudo du joueur
		vb.add(Gtk::Label.new.set_markup("<big><big><span >Liste de vos sauvegardes</span></big></big>"))
		allSaves = Dir.entries("../sauvegardes")
		allSaves.delete(".")
		allSaves.delete("..")
		indice = false
		allSaves.each{ |elt|
			tmp = elt.split('_')
			if tmp[0] == @jeu.pseudo
				indice = true
				vb.add(Gtk::Label.new.set_markup("<span foreground='white'>#{tmp[1]}</span>"))
			end
		}
		if indice == false
			vb.add(Gtk::Label.new.set_markup("<big><span >Aucune sauvegarde disponible</span></big>"))

		else
			#Création entrer pour mettre le nom de la save désirée
			@save = Gtk::Entry.new
			vb.add(@save)

			#Création du bouton JOUER
			iJouer = Gtk::Image.new(:file => "../images/boutons/jouer.png")
			@bJouer = Gtk::EventBox.new.add(iJouer)
			@bJouer.signal_connect("enter_notify_event"){
				@bJouer.remove(@bJouer.child)
				@bJouer.child = Gtk::Image.new(:file => "../images/boutons/jouerOver.png")
				@bJouer.show_all
			}
			@bJouer.signal_connect("leave_notify_event"){
				@bJouer.remove(@bJouer.child)
				@bJouer.child = Gtk::Image.new(:file => "../images/boutons/jouer.png")
				@bJouer.show_all
			}
			@bJouer.signal_connect("button_press_event") do
				charger("../sauvegardes/"+@jeu.pseudo+"_"+@save.text)
			end
			vb.add(@bJouer)
		end

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

	##
	# Charge la partie
	#
	# Param : identificateurs d'une partie
	# Retour : La grille chargée
	def charger(nomSave)
		# Deserialisation et lance le chargement
		current = ""
    nbOcc=0
		if File.exist?(nomSave)
	  	fic = File.open(nomSave)
	    fic.each_line { |ligne|
		    if ligne[0,3]=="***" then
		      case nbOcc
		        when 0
		          $map = YAML.load(current)
		        when 1
		          $hypo = YAML.load(current)
		        when 2
		          $pseudo = current.strip
		        when 3
		          $inc = current.to_i
		        when 4
		          $start = current.to_i
		        when 5
		          $cheminMap = current.strip
		        when 6
		          $nbHypo = current.to_i
					end
		    	nbOcc+=1;
		     	current = ""
		    else
		    	current+=ligne.to_s
				end
			}

			@window.destroy
			Gui.new(1, $pseudo, $cheminMap, $inc, $start, $map, $hypo, $nbHypo)
			onDestroy()
		else
			dialog = Gtk::Dialog.new("Erreur chargement",
	                             $main_application_window,
	                             Gtk::DialogFlags::DESTROY_WITH_PARENT,
	                             [ Gtk::Stock::OK, Gtk::ResponseType::NONE ])

	    # Ensure that the dialog box is destroyed when the user responds.
	    dialog.signal_connect('response') { dialog.destroy }

	    # Add the message in a label, and show everything we've added to the dialog.
	    dialog.child.add(Gtk::Label.new("Nom de sauvegarde erroné"))
	    dialog.show_all
		end

	end

end
