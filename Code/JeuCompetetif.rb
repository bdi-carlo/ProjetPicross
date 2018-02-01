# encoding: UTF-8

##
# Auteur  : Groupe 4
# Fichier : JeuCompetitif.rb
# Version : 0.1
# Date : 30/01/2018
# Cette classe représente le mode de jeu compétitif.

class JeuCompetitif

	@temps		#temps par partie qui va permettre de donner un score
	@pseudo 	#pseudo du joueur
	@difficulte	#difficulte de la partie choisie au lancement du jeu
	@penalite	#penalite ajouter au score apres avoir utiliser une aide
	@score 		#score joueur
	@highscore	#meilleur score dur joueur
	attr_accessor :pseudo,:difficulte,:penalite,:score,:highscore

	private_class_method :new

	def lancerJeu()
			timer = Timers.new(1)
			r = Random.new
			r.rand(5) + 1
			String nom = @difficulte+@taille+num
			mapres = Map.create(@taille,@taille,nom)
			mapres.Map.import()
			mapres.Map.generateTop()
			mapres.Map.generateSide()
			map = Map.create(@taille,@taille,)
			map.Map.import().empty()
			timer.start()
			while(mapres.compare(map)!=1)
				map.display()
			end
			enregistreScore()
	end

	def enregistreScore()
		if(finJeu==1)
			@score = @temps + @penalite + @difficulte
		end
		if(@score > @highscore)
			rentrerHighscore(pseudo,highscore)
		end
	end
end
