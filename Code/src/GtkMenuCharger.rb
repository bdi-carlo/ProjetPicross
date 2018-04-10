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

  def initialize(pseudo)
		super(pseudo)
		lancerFenetre()
	end
  ##
  # Crée le menu Gtk
	def lancerFenetre()
		puts("Creation fenetre Charger")

		@window = creerWindow()

		grid = Gtk::Grid.new
		hb = Gtk::Box.new(:horizontal, 10)
		vb = Gtk::Box.new(:vertical, 20)

		#Label de bordure
		hb.add(Gtk::Label.new(" "))

		#Label de bordure
		vb.add(Gtk::Label.new(""))

		#Label du pseudo
		lPseudo = Gtk::Label.new
		lPseudo.set_markup("<big><i><big><b><span foreground='white'>#{@pseudo}</span></b></big></i></big>")
		#lPseudo.wrap = true
		vb.add(lPseudo)

		#Label d'espacement
		vb.add(Gtk::Label.new("\n"))

		#Récupération de la liste des sauvegardes concercant le pseudo du joueur
		vb.add(Gtk::Label.new.set_markup("<big><big><span foreground='black'>Liste de vos sauvegardes#{"\n\n"}</span></big></big>"))
		allSaves = Dir.entries("../sauvegardes")
		allSaves.delete(".")
		allSaves.delete("..")
		indice = false
		nb=0
		allSaves.each{ |elt|
			tmp = elt.split('_')
			if tmp[0] == @pseudo
				indice = true
				nb += 1
				lab = (Gtk::Label.new.set_markup("<span foreground='white'>Save #{nb.to_s+" - "+tmp[1]}</span>"))
				event = Gtk::EventBox.new.add(lab)
				event.signal_connect("enter_notify_event"){
					@window.window.set_cursor(@cursorPointer)
				}
				event.signal_connect("leave_notify_event"){
					@window.window.set_cursor(@cursorDefault)
				}
				event.signal_connect("button_press_event") do
					charger("../sauvegardes/"+@pseudo+"_"+tmp[1])
				end
				vb.add(event)
			end
		}
		if indice == false
			vb.add(Gtk::Label.new.set_markup("<big><span foreground='white'>Aucune sauvegarde disponible</span></big>"))
		end
		hb.add(vb)

		hb.add(Gtk::Label.new("\t\t\t\t\t"))

		#Création du boutton RETOUR
		vb2 = Gtk::Box.new(:vertical,0)
		vb2.add(Gtk::Label.new("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"))
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
		vb2.add(@bRetour)
		vb2.add(Gtk::Label.new("\n"))

		hb.add(vb2)

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
              #$hypo = Hypothese.creer($map)
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
			Gui.new(0,1, $pseudo, $cheminMap, $inc, $start, $map, $hypo, $nbHypo)
			#onDestroy()
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
