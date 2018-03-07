# encoding: UTF-8
load 'Map.rb'
load 'Jeu.rb'
load 'GtkMap.rb'
load 'Score.rb'
##
# Auteur  : Groupe 4
# Fichier : JeuCompetitif.rb
# Version : 0.1
# Date : 30/01/2018
# Cette classe représente le mode de jeu compétitif.

class JeuCompetitif < Jeu

	@temps		#temps par partie qui va permettre de donner un score
	#@taille
	#@pseudo 	#pseudo du joueur
	#@difficulte	#difficulte de la partie choisie au lancement du jeu
	@penalite	#penalite ajouter au score apres avoir utiliser une aide
	@score 		#score joueur
	@highscore	#meilleur score dur joueur
	@nom_fichier
	attr_accessor :pseudo,:difficulte,:penalite,:score,:highscore,:taille,:nom_fichier

	private_class_method :new

	def JeuCompetitif.lancerJeu()
		new()
	end

	def initialize()
		super

		#exemple d'informations temporaire
		@pseudo="wass"
		@difficulte=1
		@taille=10

		#affichage temporaire
		print "pseudo : #{@pseudo} \n"
		print "diff : #{@difficulte} \n"
		print "taille : #{@taille}\n"

		#on cree la map
		nom = recupMap(@taille)
		map = Gui.new(nom,1,0)
		time = map.getTime()

		#On calcul le score
		if(@difficulte==1)
			diff=100
		elsif(@difficulte==2)
				diff=50
		else
			diff=10
		end
		@score = time + diff
		score = Score.new(@score,@pseudo,@difficulte,@nom_fichier)
		score.rentrerScore()

	end

	def recupMap(taille)

		tab= Array.new()

		if(taille == 10)
			nom = "../grilles/10x10/"
		elsif(taille == 15)
			nom = "../grilles/15x15/"
		else(taille == 20)
			nom = "../grilles/20x20/"
		end

		nomFic_maps = nom + "index"

		# En remplie un tableau avec les noms du fichier
		f = File.open(nomFic_maps, "r")
		f.each_line { |line|
			tab.push("#{line.chomp}")
		}

		f.close()

		#un numéro rundom
		r = Random.new
		num = r.rand(tab.size) + 1

		#nom du fichier exemple spirale
		@nom_fichier = tab[num]

		#nom du fichier avec le chemin exemple ../grilles/10x10/Spirale
		nomFic = nom + tab[num]

		return (nomFic)
	end

end

#on lance 
j = JeuCompetitif.lancerJeu()
