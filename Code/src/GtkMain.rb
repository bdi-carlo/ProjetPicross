begin
  require 'rubygems'
 rescue LoadError
end
require 'gtk3'
require 'rbconfig'
load "GtkMenuPrincipal.rb"

class Main < Menu

  def initialize(pseudo)
    super(pseudo)
		lancerFenetre()
  end
  ##
  # Crée le menu Gtk
	def lancerFenetre()
		puts("Creation fenetre Main")

    @window = creerWindow()

		grid = Gtk::Grid.new
		hb = Gtk::Box.new(:horizontal, 10)
		vb = Gtk::Box.new(:vertical, 20)

		#Label de bordure gauche
		hb.add(Gtk::Label.new(""))

		#Label de bordure haut
		vb.add(Gtk::Label.new("\n\n\n\n\n\n\n\n\n\n\n\n"))

    #Création de la boite d'entrée du pseudo dans un hBox
    hbPseudo = Gtk::Box.new(:horizontal, 6)
    hbPseudo.pack_start(Gtk::Label.new.set_markup("<span foreground='white'>Pseudo</span>"), :expand => false, :fill => false, :padding => 6)
    nom = Gtk::Entry.new
    hbPseudo.add(nom, :expand => false, :fill => false)
		vb.add(hbPseudo)

    #Création du bouton pour confirmer notre Pseudo
    iButton = Gtk::Image.new(:file => "../images/boutons/jouer.png")
		@button = Gtk::EventBox.new.add(iButton)
		@button.signal_connect("enter_notify_event"){
			@button.remove(@button.child)
			@button.child = Gtk::Image.new(:file => "../images/boutons/jouerOver.png")
			@button.show_all
		}
		@button.signal_connect("leave_notify_event"){
			@button.remove(@button.child)
			@button.child = Gtk::Image.new(:file => "../images/boutons/jouer.png")
			@button.show_all
		}
    @button.signal_connect("button_press_event") do
      if verifPseudo(nom.text) > 0
        @pseudo = nom.text
        puts "Pseudo: " + @pseudo
        @window.hide
				onDestroy()
        MenuPrincipal.new(@pseudo)
      end
    end
		vb.add(@button)

		hb.add(vb)

		#Label d'espacement
		hb.add(Gtk::Label.new(" "))

    grid.attach(hb,0,0,1,1)

		#Wallpaper
		image = Gtk::Image.new(:file => "../images/wallpaper.jpg")
		grid.attach(image,0,0,1,1)

		@window.add(grid)

    @window.show_all

    if !@os.downcase.include?('linux')
      dialogBox("Votre systeme d'exploitation est "+@os+". Vous risquez d\'avoir des problemes de compatibilite!")
    end

    Gtk.main
	end
  ##
  # Vérifie si le pseudo fait - de 10 caractères et ne comporte pas de caractères spéciaux
  #
  # Param : Pseudo à tester
  #
  # Retour : Validité du pseudo, 1=bon, -1 = pas bon
	def verifPseudo(unPseudo)
		if unPseudo == ""
			dialogBox("Veuillez rentrer un pseudo avant de jouer!")
			return -1
		elsif unPseudo.length > 10 || unPseudo.include?("-") || unPseudo.include?("*") || unPseudo.include?("\'") || unPseudo.include?("\"")
			dialogBox("Le pseudo doit avoir une taille maximum de 10 caracteres et pas de caracteres speciaux!")
			return -1
		else
			return 1
		end
	end

end

Main.new("")
