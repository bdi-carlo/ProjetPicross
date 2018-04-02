require 'gtk3'
begin
 require 'rubygems'
 rescue LoadError
end

load "GtkMap.rb"

class MenuChoixGrille < Menu

  def initialize(game)
		super(game)
		lancerFenetre()
	end

	def lancerFenetre()
		puts("Creation fenetre Choix Grille")

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

		##A FAIRE
		vb.add(Gtk::Label.new("test"))
		mb = Gtk::MenuBar.new

    filemenu = Gtk::Menu.new
    filem = Gtk::MenuItem.new "File"
    filem.set_submenu(filemenu)

    exit = Gtk::MenuItem.new "Exit"
    exit.signal_connect "activate" do
        Gtk.main_quit
    end

    filemenu.append(exit)
    mb.append(filem)

    vb.add(mb)

		hb.add(vb)

		grid.attach(hb,0,0,1,1)

		image = Gtk::Image.new(:file => "../images/wallpaper.jpg")
		grid.attach(image,0,0,1,1)

		@window.add(grid)

		@window.show_all

		Gtk.main
	end

end
