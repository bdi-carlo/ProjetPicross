
load "Map.rb"
load "Indice.rb"


##
# Indique si la prochaine case colorie est bonne ou non
#

# *VARIABLES D'INSTANCE*
  # * penalites : Un indice moyen correspond à 30s de pénalité
  # * rows : Représente l'abscisse de la case
  # * cols : Représente l'ordonnée de la case
  # * nbMax :  Un indice moyen peut être utilisé au maximum 2 fois

class IndiceMoyen 
	
	attr_reader :row
	attr_reader :col
	
	def initialize(grille)
		@penalites = 30
		@nbMax = 2
		@row = 0
		@col = 0
		super(grille)

	end
	

	def IndiceMoyen.create
		new()
	end
	

	def envoyerIndice
		#aleatoire sur toutes les cases 
		#verifie si la case choisie n'est pas deja remplie sinon recommence(a optimiser)
		#on prend que les cases à l'etat 0
		x = TRUE
		while x == true do
			@row = rand(@map.getRows)
			@col = rand(@map.getCols)
			if @map.accessAt(@row,@col).getColor == 0
				x = false
				
				if @map.accessAtRes(@row,@col) == 1
					@indice = "La case (#{@row},#{@col}) est coloriée\n"
				
				else
					@indice = "La case (#{@row},#{@col}) n'est pas coloriée\n"
				
				end
			end
		end

		return self 
			
	end

end

voila = IndiceMoyen.create
voila.envoyerIndice