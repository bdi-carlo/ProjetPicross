load "Map.rb"

class Indice
	@penalites
	@nbUtilisation
	
	##private_class_method :new

	def initialize
		@penalites, @nbUtilisation = 0, 0
	end		
	
	#envoie les penalites a la classe jeu pour les rajoutes au temps total
	def ajouterPenalites
		return @penalites
	end

end
