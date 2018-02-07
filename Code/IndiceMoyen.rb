class IndiceMoyen < Indice
	def initialize
		@penalites = 30
		@map = Map.create("scenario_bateau")
		@nbMax = 2
	end

#
	def revleCase
		#aleatoire sur toutes les cases 
		#verifie si la case choisie n'est pas deja remplie sinon recommence(a optimiser)
		#on prend que les cases à l'etat 0
		

	end
end
