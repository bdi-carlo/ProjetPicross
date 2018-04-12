load 'Map.rb'
load 'GtkMap.rb'

##
# Classe gérant les différents messages du didactitiel
class Didacticiel

	#@temps		#temps par partie qui va permettre de donner un score
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
	attr_accessor :etape,:message

	#def Didacticiel.lancerJeu()
	#	new()
	#end

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
			#determine quel case et si on le guide sur laquel on lui fait cliquer ?
			@message = "Bienvenue dans le didacticiel #{@pseudo},\n cliquez-glissez sur des cases pour les noircir"
			@etape += 1

		elsif(@etape == 2)
			#determine quel case et si on le guide sur laquel on lui fait cliquer ?
			@message = "Ciquez-glissez droit sur des cases pour indiquer qu'elles ne doivent pas être noircies"
			@etape += 1

		elsif(@etape == 3)
			#tout les indices ?
			@message = "Cliquez sur un des boutons d'indice \nreprésentés par un point d'interrogation"
			@etape += 1

		elsif(@etape == 4)
			#plusieurs hypothèse ?
			@message = "Les boutons d'hypothèses permettent de \nsauvegarder une position et d'y revenir. Essayez ! "
			@etape += 1

		elsif(@etape == 5)
			#plusieurs hypothèse ?
			@message = "Vous êtes maintenant en mode hypothèse cliquez-glissez \nsur des cases elle seront d'une couleur différente ! "
			@etape += 1

		elsif(@etape == 6)
			#plusieurs hypothèse ?
			@message = "Vous pouvez valider votre hypothèse ou \nla rejeter avec les boutons sur le côté "
			@etape += 1


		elsif(@etape == 7)
			#le laisser faire ou l'aider en disant ou cliquer ?
			@message = "Maintenant que vous connaissez les outils,\nles chiffres sur les côtés représentent le nombre de cases noir sur la ligne,\n Essayer maintenant de terminer la grille"
			@etape += 1

		end
		return self
	end
end
