load 'Didacticiel.rb'

class GtkDidacticiel < GtkMap
	#compteur
	#@verifcase debute a 0
	#@verifcroix debute a 0
	#@verifhypo debute a 0
	#@verifaide debute a 0
	#debute a -1 hors du didacticiel
	

=begin
	
	def initialize()
		super(charge, pseudo, cheminMap, inc, start, map, hypo, nbHypo)
		@message1 = #message1 de didacticiel
		@message2 = #message2 de didacticiel
		@message3 = #message3 de didacticiel
		#@verifcase = 0
		#@verifcroix = 0
		#@verifhypo  = 0
		#@verifaide = 0
		map = Gui.new("./didacticiel",1,0)
		boxMessage1 = Gtk::Box.new(:vertical,100)
		boxMessage2 = Gtk::Box.new(:vertical,100)
		boxMessage3 = Gtk::Box.new(:vertical,100)
		dialog = Gtk::Dialog.new("@message1",$main_application_window, Gtk::Dialog::DESTROY_WITH_PARENT,[ Gtk::Stock::OK, Gtk::Dialog::RESPONSE_NONE ])
		dialog = Gtk::Dialog.new("@message2",$main_application_window, Gtk::Dialog::DESTROY_WITH_PARENT,[ Gtk::Stock::OK, Gtk::Dialog::RESPONSE_NONE ])
		dialog = Gtk::Dialog.new("@message3",$main_application_window, Gtk::Dialog::DESTROY_WITH_PARENT,[ Gtk::Stock::OK, Gtk::Dialog::RESPONSE_NONE ])
	end
	
	
	################################a rajouter dans les fonctions ########################################

	def onEnter case
		if(@etape == 1 && @verifcase == 0)
			@verifcase += 1
			#etape du didacticiel
			@etape += 1
			affichemessage()
				                             
		elsif(@etape == 2 && @verifcroix == 0)
			@verifcroix += 1
			#etape du didacticiel
			@etape += 1
			affichemessage()
			
		end
	end
		
	def onPress hypothese
		if(@etape == 3 && @verifhypo == 0)
			@verifhypo += 1
			#etape du didacticiel
			@etape += 1
			affichemessage()
			
		end
	end
		
	def onPress aide
		if(@etape == 4 && @verifaide == 0)
			@verifaide += 1
			#etape du didacticiel
			@etape += 1
			affichemessage()

		end
	end
	
	#######################change le contenue des messages par raport aux étapes#########################
	
	def affichemessage 
		#actualise les messages dans didacticiel
		changerMessage()
		#changer message dans les boxs
	end

	#######################a rajouter pour creer les boites de dialogues#########################

	boxMessage = Gtk::Box.new(:horizontal,2)
		boxMessage1 = Gtk::Box.new(:horizontal,2)
				boxMessage1.add(@message1)	
				boxMessage1.add(@message2)	
				boxMessage1.add(@message3)	
	boxMessage.add(boxMessage1)


///ou////

		boxMessage = Gtk::Box.new(:vertical,2)
		boxMessage1 = Gtk::Box.new(:vertical,2)
		boxMessage2 = Gtk::Box.new(:vertical,2)
		boxMessage3 = Gtk::Box.new(:vertical,2)
				boxMessage1.add(@message1)	
				boxMessage2.add(@message2)	
				boxMessage3.add(@message3)	
		boxMessage.add(boxMessage1)
		.show_all

	
=end


