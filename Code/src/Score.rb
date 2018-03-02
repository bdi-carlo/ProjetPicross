

class Score

# Le score du joueur est sauvegardé dans un fichier où sont répertoriés le temps, le pseudo et la difficulté choisie par le joueur


 	# 3 Variables d'instance : le temps, le pseudo, la difficulté
	@temps
	@pseudo
	@difficulte
	@nomGrille
	@nomFichier

	def initialize(temps, pseudo, difficulte, nomGrille)
		@temps = temps
		@pseudo = pseudo
		@difficulte = difficulte
		@nomGrille = nomGrille
		@nomFichier = "../Sauvegardes/Score.txt"
	end


	# Méthode qui permet de rentrer le score d'un joueur dans un fichier nommé "Score.txt"
	def rentrerScore()

=begin
		f = File.new(@nomFichier,"w")


		f.puts("#{@temps} " + "#{@pseudo} " + "#{@difficulte}")

		f.close()
=end

		f = File.open(@nomFichier, "a+")
		f.puts("#{@temps} " + "#{@pseudo} " + "#{@difficulte} " + "#{@nomGrille}")
		f.close()

	end

	def lireScore()

		f = File.open(@nomFichier, "r")
		f.each_line do |line|
			print "#{line}"
		end
		print "\n"

		f.close()
	end


	##
	# Affiche le highscore d'une personne / grille
	#
	# Param : Le nom d'une grille ou d'un pseudo ou d'une difficulte
	# Retour : Ligne du tableau des scores correspondante
	def recupHS(unNom)

		tabScores = Array.new()
		toDel = Array.new()

		# En remplie un tableau avec les scores du fichier
		f = File.open(@nomFichier, "r")
		f.each_line do |line|
			tabScores.push("#{line}")
		end
		f.close()

		# On garde que les lignes correspondants a la grille/nom/difficulte/etc
		tabScores.each do |score|
			if !(score.include?(unNom))
				toDel.push(score)
			end
		end
		for score in toDel
			tabScores.delete(score)
		end

		## On trie le tableau en fonction des score, on l'affiche et on le renvoie
		#
		tabScoresSorted = Array.new()
		for score in tabScores
			tabScoresSorted.push(score.split(/ /))
		end

		t = tabScoresSorted.sort_by(&:first).first
		scoreRes = t[0]+" "+t[1]+" "+t[2]+" "+t[3]
		print "----- HIGHSCORE de "+unNom+" -----\n- "+scoreRes+"\n"


		#return scoreRes
		return tabScoresSorted.sort_by(&:first).first

	end

	##
	# Affiche les highscores d'une personne / grille
	#
	# Param : Le nom d'une grille ou d'un pseudo ou d'une difficulte
	# Retour : Tableau des scores correspondant
	def afficherHS(unNom)


		tabScores = Array.new()

		# En remplie un tableau avec les scores du fichier
		f = File.open(@nomFichier, "r")
		f.each_line do |line|
			tabScores.push("#{line}")
		end
		f.close()

		# On garde que les lignes correspondants de la grille/nom/difficulte/etc
		for score in tabScores
			if !(score.include?(unNom))
				tabScores.delete(score)
			end
		end

		# WORK IN PROGRESS
		tabScoresSorted = Array.new()
		for score in tabScores
			tabScoresSorted.push(score.split(/ /))
		end

		# On affiche les scores et on retourne le tableau
		print "----- HIGHSCORE(s) de "+unNom+" -----\n"
		for score in tabScoresSorted.sort_by(&:first)
			print "- "+score[0]+" "+score[1]+" "+score[2]+"\n"
		end
		return tabScoresSorted.sort_by(&:first)

	end

end


	score = Score.new("30","Arthur", "facile", "Bateau")
	score.rentrerScore()

	score = Score.new("50","Valentin", "HARD", "Cobra")
	score.rentrerScore()

	score = Score.new("08","Valentin", "HARD", "Cobra")
	score.rentrerScore()

	score = Score.new("12","Martin", "HARD", "Cobra")
	score.rentrerScore()

	score = Score.new("6830","Benoit", "facile", "Test2x2")
	score.rentrerScore()



	score.lireScore()

	score.recupHS("Valentin")
	score.afficherHS("Cobra")
