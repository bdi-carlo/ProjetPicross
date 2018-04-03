require 'gtk3'
begin
 require 'rubygems'
 rescue LoadError
end

load "GtkMap.rb"

class MenuChoixGrille < Menu

  def initialize(game)
		super(game)
		@vListe = nil
		lancerFenetre()
	end

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
		lPseudo.set_markup("<big><i><big><b><span foreground='white'>#{@jeu.pseudo}</span></b></big></i></big>")
		@vb.add(lPseudo)

		#Label d'espacement
		@vb.add(Gtk::Label.new("\n\n\n"))

		#Radio buttons
		@hb2 = Gtk::Box.new(:horizontal, 10)
		@vb2 = Gtk::Box.new(:vertical, 5)
		@facile = Gtk::RadioButton.new(:label => "Niveau Facile")
    @moyen = Gtk::RadioButton.new(:member => @facile, :label => "Niveau Moyen")
    @difficile = Gtk::RadioButton.new(:member => @facile, :label => "Niveau Difficile")
		@vb2.add(@facile).add(@moyen).add(@difficile)
		@vb3 = Gtk::Box.new(:vertical, 5)
		@cinq = Gtk::RadioButton.new(:label => "5 X 5")
    @dix = Gtk::RadioButton.new(:member => @cinq, :label => "10 X 10")
    @quinze = Gtk::RadioButton.new(:member => @cinq, :label => "15 X 15")
		@vingt = Gtk::RadioButton.new(:member => @cinq, :label => "20 X 20")
		@vb3.add(@cinq).add(@dix).add(@quinze).add(@vingt)

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
		@bConfirmer.signal_connect("button_press_event") do
			#Récupération de la liste des grilles suivant le choix
			if @facile.active?
				if @dix.active?
					puts "test"
					@vListe = vListeFichier("../grilles/facile/10x10")
				end
			end
		end

		@vb.add(@bConfirmer)
		if @vListe != nil
			puts "pas nil"
			@vb.add(@vListe)
		end

		@hb.add(@vb)

		grid.attach(@hb,0,0,1,1)

		image = Gtk::Image.new(:file => "../images/wallpaper.jpg")
		grid.attach(image,0,0,1,1)

		@window.add(grid)

		@window.show_all

		Gtk.main
	end

	##
	#Méthode qui retourne une vbox contenant la liste des fichiers d'un répertoire
	#Param : le répertoire
	def vListeFichier( unRepertoire )
		vb = Gtk::Box.new(:vertical, 5)
		vb.add(Gtk::Label.new.set_markup("<big><big><span foreground='black'>Liste des grilles#{"\n\n"}</span></big></big>"))
		allGrids = Dir.entries(unRepertoire)
		allGrids.delete(".")
		allGrids.delete("..")
		allGrids.each{ |elt|
			puts elt
			vb.add(Gtk::Label.new.set_markup("<span foreground='white'>#{elt}</span>"))
		}
		return vb
	end

end
