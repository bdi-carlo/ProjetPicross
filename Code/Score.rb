class Score 

# Le score du joueur est sauvegardé dans un fichier où sont répertoriés le temps, le pseudo et la difficulté choisie par le joueur



 # 3 Variables d'instance : le temps, le pseudo, la difficulté
	@temps
	@pseudo
	@difficulte
	
	def initialize(temps, pseudo, difficulte) 
		@temps = temps
		@pseudo = pseudo
		@difficulte = difficulte
	end
	
	# Méthode qui permet de rentrer le score d'un joueur
	
	def rentrerScore()
		print "Nom du fichier a ouvrir : "
		nomFichier = gets.chomp # L'utisateur rentre le nom du fichier à ouvrir
		#begin
		
		fichier = File.open(nomFichier, "r").read
		fichier.each_line do |line|
			print "#{line}"
		end 
		
		#rescue
			#puts "Le fichier n'a pas pu etre ouvert, veuillez saisir un nom correct"
			#retry
		#end
		
		
		
		
		
	end
end


score = Score.new(30,"Arthur", "facile") 
score.rentrerScore()

		
