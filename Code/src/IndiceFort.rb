load "Map.rb"
load "Indice.rb"

class IndiceFort < Indice

##
# Indique si la prochaine case colorie est bonne ou non
#

# *VARIABLES D'INSTANCE*
  # * map :  Représente la grille
  # * penalites : Un indice fort correspond à 120s de pénalité
  # * rows : Représente l'abscisse de la case
  # * cols : Représente l'ordonnée de la case
  # * nbMax :  Un indice fort ne peut être utilisé qu'une fois


	@map
	@col
	@row

	def IndiceFort.create(grille,row,col)
		new(grille,row,col)
	end

	private_class_method:new

	def initialize(grille,row, col)
		@penalites = 120
		@col = col
		@row = row
		@nbMax = 1
		super(grille)
	end


##
# Vérification de la case sur la grille
#
#
# Vérification dans la grille résultat si la case sélectionnée est coloriée ou non
#
	def envoyerIndice()
		if(@nbMax != 0)
			if(@map.accessAtRes(@row,@col)==1)
				@indice = "La case se trouvant en (#{@row+1},#{@col+1}) est coloriée\n"
			else
				@indice = "La case se trouvant en (#{@row+1},#{@col+1}) n'est pas coloriée\n"
			end
		else
				@indice = "Nombre d'utilisation maximum de cet indice atteint."
		end

		return self
	end

end
