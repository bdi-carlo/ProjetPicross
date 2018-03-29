
load "Map.rb"

require "yaml"
require "date"

class Save

	#  *VARIABLES D'INSTANCE*
	# * nomSave : nom de la sauvegarde
	# * grille : grille objet de la sauvegarde

	##
	# -
	#
	# Param : identificateurs d'une partie
	def genNomSave(pseudo, difficulte, taille)

		d = DateTime.now
		@nomSave = "Save_"+pseudo+"_"+difficulte+"_"+taille+"_"+d.strftime("%d/%m/%Y-%H:%M")

	end


	##
	# Sauvegarde la partie
	#
	# Param : identificateurs d'une partie
	def sauvegarder(unNom, uneGrille)

		@grille=uneGrille
		@nomSave=unNom

		# Serialisation de la grille
		grilleS = @grille.to_yaml()

		# Ecriture de la grille dans le fichier
		monFichier = File.open("../sauvegardes/"+@nomSave, "w")
		monFichier.write(grilleS)
		monFichier.close
	end

	##
	# Sauvegarde la partie
	#
	# Param : identificateurs d'une partie
	def sauvegarders(uneGrille)

		@grille=uneGrille
		@nomSave=genNomSave()

		# Serialisation de la grille
		grilleS = @grille.to_yaml()

		# Ecriture de la grille dans le fichier
		monFichier = File.open(@nomSave, "w")
		monFichier.write(grilleS)
		monFichier.close
	end

	##
	# Affiche la sauvegarde
	#
	# Retour : le nom de la grille
	def to_s()
		return @nomSave
	end



end



# Test Obsolete  car Map.rb à été modifié
=begin
	# Partie test
	grille1 = Map.create(18,18,"./scenario_bateau")
	grille1.import()

	# Exemple de sauvegarde d'une grille vierge
	s1 = Save.new()
	s1.sauvegarder("Sauvegardes/grille1", grille1)

	# On modifie cette meme grille après l'avoir charger, puis on la sauvegarde
	s2 = Save.new()
	grille2 = s2.charger("Sauvegardes/grille1")
	grille2.putAt!(0,0,1)
	grille2.putAt!(0,1,0)
	s2.sauvegarder("Sauvegardes/grille2",grille2)



	s1 = Save.new()
	print s1.genNomSave("valoche", "hard", "10x10")
	print "\n"

=end
