
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

class IndiceMoyen < Indice

	attr_reader :row
	attr_reader :col


	def IndiceMoyen.create(grille)
		new(grille)
	end

	private_class_method:new

	def initialize(grille)
		super(grille)
		@penalites = 30
		@nbMax = 2
		@row = 0
		@col = 0
	end


	def envoyerIndice
		#aleatoire sur toutes les cases
		#verifie si la case choisie n'est pas deja remplie sinon recommence(a optimiser)
		#on prend que les cases à l'etat 0
		x = true
		while x == true do
			@row = rand(@map.rows)
			@col = rand(@map.cols)
			if @map.accessAt(@row,@col).value == 0
				x = false

				if @map.accessAtRes(@row,@col) == 1
					@indice = "La case (#{@row+1},#{@col+1}) est coloriée\n"

				else
					@indice = "La case (#{@row+1},#{@col+1}) n'est pas coloriée\n"

				end
			end
		end

		return self

	end

end
=begin
map = Map.create("../grilles/scenario/Bateau")
voila = IndiceMoyen.create(map)
print voila.envoyerIndice.indice
=end
