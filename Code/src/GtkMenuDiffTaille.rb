require 'gtk3'
begin
 require 'rubygems'
 rescue LoadError
end

load "GtkMap.rb"

def onDestroy
	puts "Fin de l'application"
	Gtk.main_quit
end

  #http://www.rubydoc.info/gems/gtk3/Gtk/Paned
  #http://www.rubydoc.info/gems/gtk3/3.0.7/Gtk/Paned
class GtkMenuDiffTaille

  def initialize()

		Gtk.init

		@window = Gtk::Window.new
		# Titre de la fenêtre
		@window.set_title("Bienvenue")
		# Taille de la fenêtre
		@window.set_default_size(200,150)
		# Réglage de la bordure
		@window.border_width=3
		# On peut redimensionner
		@window.set_resizable(false)
		# L'application est toujours centrée
		@window.set_window_position(Gtk::WindowPosition::CENTER_ALWAYS)

		#Création du panneau verical
		#Première fenêtre
		vp = Gtk::Paned.new(:vertical)

		vb = Gtk::Box.new(:vertical,1)

		table = Gtk::Table.new(3,2)

		# Sélection de la difficulté
		lDiff = Gtk::Label.new("Niveau de difficulté:")

		bFacile = Gtk::Button.new(:label =>"Facile", :use_underline => nil, :stock_id => nil)
		bMoyen = Gtk::Button.new(:label =>"Moyen", :use_underline => nil, :stock_id => nil)
		bDifficile = Gtk::Button.new(:label =>"Difficile", :use_underline => nil, :stock_id => nil)

		table.attach(lDiff, 0, 1, 0, 1)
		table.attach(bFacile, 1, 2, 0, 1)
		table.attach(bMoyen, 2, 3, 0, 1)
		table.attach(bDifficile, 1, 2, 1, 2)

		vb.add(table)

		#Seconde fenêtre
		vb1 = Gtk::Box.new(:vertical,1)

		table1 = Gtk::Table.new(4,3)

		lGrille = Gtk::Label.new("Taille de Grille")

		bT5 = Gtk::Button.new(:label =>"5 x 5", :use_underline => nil, :stock_id => nil)
		bT10 = Gtk::Button.new(:label =>"10 x 10", :use_underline => nil, :stock_id => nil)
		bT15 = Gtk::Button.new(:label =>"15 x 15", :use_underline => nil, :stock_id => nil)
		bT20 = Gtk::Button.new(:label =>"20 x 20", :use_underline => nil, :stock_id => nil)
		bT25 = Gtk::Button.new(:label =>"25 x 25", :use_underline => nil, :stock_id => nil)
		bT30 = Gtk::Button.new(:label =>"30 x 30", :use_underline => nil, :stock_id => nil)
		bRetour = Gtk::Button.new(:label =>"Retour")

		table1.attach(lGrille, 0, 1, 0, 2)
		table1.attach(bT5, 1, 2, 0, 1)
		table1.attach(bT10, 2, 3, 0, 1)
		table1.attach(bT15, 3, 4, 0, 1)
		table1.attach(bT20, 1, 2, 1, 2)
		table1.attach(bT25, 2, 3, 1, 2)
		table1.attach(bT30, 3, 4, 1, 2)
		table1.attach(bRetour,2,3,2,3)

		vb1.add(table1)

		vp.set_size_request(200, -1)
		vp.set_position(200)
		vp.add1(vb)
		vp.add2(vb1)
		#vp.pack1(vb,:resize => true,:shrink => false)
		#vp.pack2(vb1, :resize => false,:shrink => false)
		vb.set_size_request(200, -1)
		#vb.show_all
		#vb1.hide

		bFacile.signal_connect "clicked" do
			vp.set_position(175)
			vp.set_position(125)
			vp.set_position(75)
			vb.set_size_request(0,-1)
			vp.set_position(0)
		end

		bMoyen.signal_connect "clicked" do
			vp.set_position(175)
			vp.set_position(125)
			vp.set_position(75)
			vb.set_size_request(0,-1)
			vp.set_position(0)
		end

		bDifficile.signal_connect "clicked" do
			vp.set_position(175)
			vp.set_position(125)
			vp.set_position(75)
			vb.set_size_request(0,-1)
			vp.set_position(0)
		end

		bT10.signal_connect "clicked" do
			@window.hide
			Gui.new("../grilles/10x10/Neuf",1,0)
			@window.show_all
		end

		bRetour.signal_connect "clicked" do

			vb.set_size_request(200, -1)
			vp.set_position(75)
			vp.set_position(125)
			vp.set_position(175)
			vp.set_position(200)
		end

		@window.signal_connect "destroy" do
			onDestroy
		end

		@window.add(vp)

		@window.show_all

		Gtk.main
	end
end

GtkMenuDiffTaille.new()
