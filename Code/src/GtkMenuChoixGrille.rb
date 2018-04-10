require 'gtk3'
begin
 require 'rubygems'
 rescue LoadError
end

load "GtkMap.rb"

class MenuChoixGrille < Menu

  def initialize(pseudo, indiceTypeJeu)
		super(pseudo)
		@indiceTypeJeu = indiceTypeJeu
		@vListe = nil
		@flagListe = false
		lancerFenetre()
	end
  ##
  # Crée le menu en Gtk
	def lancerFenetre()
		puts("Creation fenetre Choix Grille")

		@window = creerWindow()

		grid = Gtk::Grid.new
		@hb = Gtk::Box.new(:horizontal, 10)
		@vb = Gtk::Box.new(:vertical, 20)

		#Label de bordure
		@hb.add(Gtk::Label.new(" "))

		#Label de bordure
		@vb.add(Gtk::Label.new("\n"))

		#Label du pseudo
		lPseudo = Gtk::Label.new
		lPseudo.set_markup("<big><i><big><b><span foreground='white'>#{@pseudo}</span></b></big></i></big>")
		@vb.add(lPseudo)

		#Label d'espacement
		@vb.add(Gtk::Label.new("\n"))

		@vb.add(Gtk::Label.new.set_markup("<big><big><span foreground='black'>Choix type de grille#{"\n\n"}</span></big></big>"))

		#Radio buttons
		@hb2 = Gtk::Box.new(:horizontal, 10)
		@vb2 = Gtk::Box.new(:vertical, 5)
		@facile = Gtk::RadioButton.new(:label => "Niveau Facile")
		@facile.child.set_markup("<span foreground='white'>Niveau Facile</span>")
    @moyen = Gtk::RadioButton.new(:member => @facile, :label => "Niveau Moyen")
		@moyen.child.set_markup("<span foreground='white'>Niveau Moyen</span>")
    @difficile = Gtk::RadioButton.new(:member => @facile, :label => "Niveau Difficile")
		@difficile.child.set_markup("<span foreground='white'>Niveau Difficile</span>")
		@vb2.add(@facile).add(@moyen).add(@difficile)
		@vb3 = Gtk::Box.new(:vertical, 5)
    @dix = Gtk::RadioButton.new(:label => "10 X 10")
		@dix.child.set_markup("<span foreground='white'>10 X 10</span>")
    @quinze = Gtk::RadioButton.new(:member => @dix, :label => "15 X 15")
		@quinze.child.set_markup("<span foreground='white'>15 X 15</span>")
		@vingt = Gtk::RadioButton.new(:member => @dix, :label => "20 X 20")
		@vingt.child.set_markup("<span foreground='white'>20 X 20</span>")
		@vb3.add(@dix).add(@quinze).add(@vingt)

		@hb2.add(@vb2).add(@vb3)
		@vb.add(@hb2)

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
		@vb.add(@bConfirmer)

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
			MenuJouer.new(@pseudo)
		end
		@vb.add(@bRetour)

		@bConfirmer.signal_connect("button_press_event") do
			#Récupération de la liste des grilles suivant le choix
			if @facile.active?
				if @dix.active?
					afficheListeFichier("../grilles/facile/10x10")
				end
				if @quinze.active?
					afficheListeFichier("../grilles/facile/15x15")
				end
				if @vingt.active?
					afficheListeFichier("../grilles/facile/20x20")
				end
			end
			if @moyen.active?
				if @dix.active?
					afficheListeFichier("../grilles/moyen/10x10")
				end
				if @quinze.active?
					afficheListeFichier("../grilles/moyen/15x15")
				end
				if @vingt.active?
					afficheListeFichier("../grilles/moyen/20x20")
				end
			end
			if @difficile.active?
				if @dix.active?
					afficheListeFichier("../grilles/difficile/10x10")
				end
				if @quinze.active?
					afficheListeFichier("../grilles/difficile/15x15")
				end
				if @vingt.active?
					afficheListeFichier("../grilles/difficile/20x20")
				end
			end
		end

		@hb.add(@vb)

		@hb.add(Gtk::Label.new("\t\t\t\t\t\t\t\t"))

		grid.attach(@hb,0,0,1,1)

		image = Gtk::Image.new(:file => "../images/wallpaper.jpg")
		grid.attach(image,0,0,1,1)

		@window.add(grid)

		@window.show_all

		Gtk.main
	end

	##
	# Méthode qui retourne une vbox contenant la liste des fichiers d'un répertoire
  #
	# Param : le répertoire
	def afficheListeFichier( unRepertoire )
		if @flagListe
			@hb.remove(@hb.children.last)
		end
		vb = Gtk::Box.new(:vertical, 5)
    if @os.downcase.include?('darwin')
      vb.add(Gtk::Label.new("\n\n\n\n\n\n\n\n\n"))
    end
		vb.add(Gtk::Label.new.set_markup("<big><big><span foreground='black'>#{"\n\n\n\n\n\n\n\n\n\n"}Liste des grilles#{"\n"}</span></big></big>"))
		allGrids = Dir.entries(unRepertoire)
		allGrids.delete(".")
		allGrids.delete("..")
		allGrids.delete("index")
		allGrids.delete(".gitkeep")
		if allGrids.length == 0
			vb.add(Gtk::Label.new.set_markup("<big><b><span foreground='white'>Pas de grille disponible</span></b></big>"))
		else
			allGrids.each{ |elt|
				lab = Gtk::Label.new.set_markup("<big><b><span foreground='white'>#{elt}</span></b></big>")
				event = Gtk::EventBox.new.add(lab)
				event.signal_connect("enter_notify_event"){
					@window.window.set_cursor(@cursorPointer)
				}
				event.signal_connect("leave_notify_event"){
					@window.window.set_cursor(@cursorDefault)
				}
				event.signal_connect("button_press_event") do
					#indiceTypeJeu => 0 = normal, 1 = compet, 2 = aventure
          @window.destroy
					Gui.new(@indiceTypeJeu, 0, @pseudo, unRepertoire+"/"+elt, 1, 0, nil, nil, nil)
				end
				vb.add(event)
			}
		end
		@flagListe = true
		@hb.add(vb)
		@window.show_all
	end

end
