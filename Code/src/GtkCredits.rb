begin
  require 'rubygems'
 rescue LoadError
end
require 'gtk3'
##
# Menu affichant les crédits
class Credits < Menu

  def initialize(pseudo)

    puts("Creation de la fenetre")

    #Création de la fenetre
    @window = creerWindow()
    grid = Gtk::Grid.new
		hb = Gtk::Box.new(:horizontal, 10)
		vb = Gtk::Box.new(:vertical, 20)
    vb.add(Gtk::Label.new("\n\n"))
    vb.add(Gtk::Label.new().set_markup("<span foreground='white'>
    Picross réalisé dans le cadre d'un projet de L3 informatique à l'université du Mans par :#{"\n"}
    - Benjamin Di Carlo, Documentaliste#{"\n"}
    - Benoit Combasteix, Chef de groupe#{"\n"}
    - Nathan Oualet#{"\n"}
    - Arthur Prod'homme#{"\n"}
    - Ouassim Messagier#{"\n"}
    - Samed Oktay#{"\n"}
    - Valentin Lion#{"\n"}
    - Martin Lebourdais#{"\n"}
    Git du projet => <a href = 'https://github.com/bdi-carlo/ProjetPicross'>https://github.com/bdi-carlo/ProjetPicross</a>
</span>"))
    #Création du boutton HOME
		iHome = Gtk::Image.new(:file => "../images/boutons/home.png")
		@bHome = Gtk::EventBox.new.add(iHome)
		@bHome.signal_connect("enter_notify_event"){
			@bHome.remove(@bHome.child)
			@bHome.child = Gtk::Image.new(:file => "../images/boutons/homeOver.png")
			@bHome.show_all
		}
		@bHome.signal_connect("leave_notify_event"){
			@bHome.remove(@bHome.child)
			@bHome.child = Gtk::Image.new(:file => "../images/boutons/home.png")
			@bHome.show_all
		}
		@bHome.signal_connect("button_press_event") do
			onDestroy()
			MenuPrincipal.new(pseudo)
		end
    hb2 = Gtk::Box.new(:horizontal, 300)
    hb2.add(Gtk::Label.new("\t\t\t\t\t"))
    hb2.add(@bHome)
    vb.add(hb2)
    hb.add(vb)
		#Label d'espacement
		hb.add(Gtk::Label.new(" "))

    grid.attach(hb,0,0,1,1)

		#Wallpaper
		image = Gtk::Image.new(:file => "../images/wallpaperInGamePetit.jpg")
		grid.attach(image,0,0,1,1)

		@window.add(grid)

    @window.show_all

    Gtk.main

  end

  ##
  # Callback de la fermeture de l'appli


end
