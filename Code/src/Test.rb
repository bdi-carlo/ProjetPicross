require 'gtk3'


class RubyApp

    def initialize
      init_ui
    end

    def init_ui
			Gtk.init

			@window = Gtk::Window.new

      mb = Gtk::MenuBar.new

      filemenu = Gtk::Menu.new
      filem = Gtk::MenuItem.new "File"
      filem.set_submenu filemenu

      exit = Gtk::MenuItem.new "Exit"
      exit.signal_connect "activate" do
          Gtk.main_quit
      end

      filemenu.append exit

      mb.append filem

      vbox = Gtk::Box.new :vertical, 2

      vbox.pack_start mb, :expand => false,
          :fill => false, :padding => 0

      @window.add vbox

      @window.set_title "Simple menubar"
      @window.signal_connect "destroy" do
          Gtk.main_quit
      end

      @window.set_default_size 300, 200
      @window.set_window_position :center

      @window.show_all

			Gtk.main
    end
end


RubyApp.new
