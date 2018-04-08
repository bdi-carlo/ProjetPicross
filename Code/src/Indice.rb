load "Map.rb"

class Indice

##
# Classe abstraite
#

# *VARIABLES D'INSTANCE*
  # * map :  Représente la grille
  # * penalites : Un indice est pénalisant en terme de temps suivant son niveau
  # * indice : résultat obtenu suivant l'indice utilisé

	@penalites
	@map
	@indice

	attr_reader :indice

	def initialize(grille)
		@penalites = 0
		@map = grille
		@indice = ""
	end

	##
	# Envoie les penalites a la classe jeu pour les rajoutes au temps total
	def ajouterPenalites
		return @penalites
	end

	def envoyerIndice
	end

end
