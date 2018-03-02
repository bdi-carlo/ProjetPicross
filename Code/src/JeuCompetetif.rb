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
		num = r.rand(5) + 1
		print "#{num}\n"
		nom = "../grilles/Basic/#{@difficulte}#{@taille}2.txt"
		nom_fic="#{@difficulte}#{@taille}#{num}"
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

	end

end


j = JeuCompetitif.lancerJeu()
