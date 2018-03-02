load Map.rb

class IndiceFort < Indice

##
# Indique si la prochaine case colorie est bonne ou non
#
	
	@map
	@colonne
	@ligne

	def initialize(grille, colonne, ligne)
		@penalites = 120
		@map = grille
		@colonne = colonne
		@ligne = ligne
		@nbMax = 1
	end
	

##
# Vérification de la case sur la grille
# 
#
# Retourne vrai si la case sélectionnée est coloriée, faux sinon
#
	def envoyerIndice()
		if(@map.accessAtRes(@ligne,@colonne))
			return true ;
		else 
			return false ;
		end
	end
end
