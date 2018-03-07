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
	attr_accessor :pseudo,:difficulte,:penalite,:score,:highscore,:taille

	private_class_method :new

	def JeuCompetitif.lancerJeu()
		new()
	end

	def initialize()
		super
		@pseudo="wass"
		@difficulte=1
		@taille=10
		print "pseudo : #{@pseudo} \n"
		print "diff : #{@difficulte} \n"
		print "taille : #{@taille}\n"
		r = Random.new
		num = r.rand(2) + 1
		print "Random : #{num}\n"
		if(taille == 10)
			nom = "../grilles/10x10/"
		elsif(taille == 15)
			nom = "../grilles/15x15/"
		else(taille == 20)
			nom = "../grilles/20x20/"
		end
		f = File.open("../grilles/10x10/index", "r")
		nb=0
		f.each_line do |line|
			nb += 1
			if(nb == num)
				line = line.chomp
				nom = nom + "#{line}"		
				nom_fic = "#{line}"
				printf "Nom : #{nom}"
				printf "Fich : #{nom_fic}"
			end
		end

		
		map = Gui.new(nom,1,0)
		time = map.getTime()
		if(@difficulte==1)
			diff=100
		elsif(@difficulte==2)
				diff=50
		else
			diff=10
		end
		@score = time + diff
		score = Score.new(@score,@pseudo,@difficulte,nom_fic)
		score.rentrerScore()

		f.close()

	end

end


j = JeuCompetitif.lancerJeu()
