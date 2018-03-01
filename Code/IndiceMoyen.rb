
class IndiceMoyen 
	def initialize
		@penalites = 30
		@map = Map.create("scenario_bateau")
		@nbMax = 2
		@row = 0
		@cols = 0
		#boolean verifie si la case de la grille resultat est noir ou blanche true = noir false = blanche
		@black

	end

	def IndiceMoyen.create
		new()
	end

	def envoyerIndice
		#aleatoire sur toutes les cases 
		#verifie si la case choisie n'est pas deja remplie sinon recommence(a optimiser)
		#on prend que les cases à l'etat 0
		
		while x == TRUE do
			@row = rand(getRows)
			@cols = rand(getCols)
			if @map.accessAt(@row,@cols).getColor == 0
				x = FALSE
				
				if @map.accessAtRes(@row,@cols) == 1
					@black = TRUE
				
				else
					@black = FALSE
				end
			end
		end
		#print"#{row}"
			
	end

	def getBlack()
		return @black
	end
		
	def getRow()
		return @row
	end

	def getCols()
		return @cols
	end
		
end

voila = IndiceMoyen.create
voila.reveleCase
