begin
  require 'rubygems'
 rescue LoadError
end
require 'gtk3'
load "GtkMap.rb"

class MenuJouer

  def initialize()

    puts("Creation fenetre Jouer")

    #Gtk.init

    #Création de la fenêtre
    @window = Gtk::Window.new("PiCross")
		@window.override_background_color(:normal,Gdk::RGBA.new(32,32,32,1))
    @window.set_size_request(300, 300)
    @window.resizable=FALSE
    @window.set_window_position(:center_always)
    

    @provider = Gtk::CssProvider.new
    @window.border_width=3

    @window.signal_connect('destroy') {onDestroy}

    #Création d'une VBox
    vb = Gtk::Box.new(:vertical, 5)
    vb.set_homogeneous(false)

		#Création d'un Label
		l = Gtk::Label.new("Choix du mode")
		vb.pack_start(l)

    #Création du boutton Aventure
    bAventure = Gtk::Button.new(:label => "Aventure", :use_underline => nil, :stock_id => nil)
    bAventure.name = "bAventure" 
    vb.pack_start(bAventure, :expand => true, :fill => true)
    @provider.load(:data=>"#bAventure {background-color : red ;
                                    }")

    #Création du boutton Competition
    bCompetition = Gtk::Button.new(:label => "Competition", :use_underline => nil, :stock_id => nil)
    vb.pack_start(bCompetition, :expand => true, :fill => true)

    #Création du boutton Normal
    bNormal = Gtk::Button.new(:label => "Normal", :use_underline => nil, :stock_id => nil)
    vb.pack_start(bNormal, :expand => true, :fill => true)
    bNormal.signal_connect "clicked" do
      @window.destroy
      Gui.new("../grilles/10x10/Neuf",1,0)
      onDestroy()
    end

    #Création du boutton Didacticiel
    bDidacticiel = Gtk::Button.new(:label => "Didacticiel", :use_underline => nil, :stock_id => nil)
    vb.pack_start(bDidacticiel, :expand => true, :fill => true, :padding => 0)

		#Création du boutton Retour
    bRetour = Gtk::Button.new(:label => "Retour", :use_underline => nil, :stock_id => nil)
    vb.pack_start(bRetour, :expand => true, :fill => true, :padding => 0)
		bRetour.signal_connect "clicked" do
			@window.destroy
			onDestroy()
		end

    @window.add(vb)
    @window.show_all

    apply_style(@window, @provider)
    Gtk.main

  end

  ##
  # Callback de la fermeture de l'appli
  def onDestroy
    puts "Fin de l'application"
    #Quit 'propre'
    Gtk.main_quit
  end
  
  def apply_style(widget, provider)
    style_context = widget.style_context
    style_context.add_provider(provider, Gtk::StyleProvider::PRIORITY_USER)
    return unless widget.respond_to?(:children)
    widget.children.each do |child|
      apply_style(child, provider)
    end
  end

end
