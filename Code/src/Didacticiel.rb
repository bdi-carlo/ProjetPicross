load 'Map.rb'
load 'Jeu.rb'
load 'GtkMap.rb'


public class Didacticiel 

	@temps		#temps par partie qui va permettre de donner un score
	#@taille
	#@pseudo 	#pseudo du joueur
	#@difficulte	#difficulte de la partie choisie au lancement du jeu
	#@penalite	#penalite ajouter au score apres avoir utiliser une aide
	#@score 		#score joueur
	#@highscore	#meilleur score dur joueur
	@message 	#message a afficher dans le jeu 
	
	@etape		#int qui s'incremente à chaque étape
				#etape 1: cliquer sur une case pour la noircir,
				#etape 2: clique droit pour mttre une croix
				#etape 3: se servir du système d'indice,
				#etape 4: se servir du système d'hypothèse
				#etape 5: terminer la grille
	attr_accessor :pseudo,:score,:chaine,:etape,:message1,:message2,:message3

	def Didacticiel.lancerJeu()
		new()
	end
	
	def initialize()
		@message = "bienvenue dans le didacticiel #{@pseudo}"
		#en attente du dossier final
		#nom = "./grilles/didacticiel/sonnom"
		#map = Gui.new(nom,0,0)
		@etape = 1
	end
		
	##
	#change les messages à afficher 
	#(rajouter des étapes pour expliquer comment choisir sur quelle case cliquer ?
	#(rajouter des étapes pour les différents indices ?)
	#
	def changerMessage()
		#definir le nombre d'etape 
		if(@etape == 1)
			#determine quel case et si on le guide sur laquel on lui fait cliquer
			@message = "cliquer sur une case pour la noircir"
			@etape += 1

		elsif(@etape == 2)	
			#determine quel case et si on le guide sur laquel on lui fait cliquer
			@message = "clique droit sur une case pour indiquer qu'elle ne doit pas etre noircie"
			@etape += 1

		elsif(@etape == 3)	
			#tout les indices ?
			@message = "clique sur un des boutons d'indice representes par ?"
			@etape += 1

		elsif(@etape == 4)	
			#plusieurs hypothèse ?
			@message = "les boutons d'hypotheses permet de sauvegarder une position et d'y revenir "
			@etape += 1

		elsif(@etape == 5)	
			#le laisser faire ou l'aider en disant ou cliquer ?
			@message = "maintenant que tu connais les outils termine la grille"
			@etape += 1

		end
		return self
	end
end

