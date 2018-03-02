load "Indice.rb"
load "Map.rb"

class IndiceFaible < Indice

	attr_reader :indice

	def initialize
		@penalites = 15
		@indice = nil
		@orientation = false
		@map = Map.create("../grilles/s  cenario/Bateau")
		@nbMax = 3
		@nbUtilisation = 0
	end

##
# renvoie indice chaine de caractere contenant le plus gros chiffre "max" et sa position
#

	def envoyerIndice
		if @nbUtilisation < @nbMax
			@nbUtilisation += 1
			somme = 0
			max = 0
			side = @map.getSide()
			top = @map.getTop()
			i = 0
			j = 0

			# calcule le max sur les lignes
			for row in side do
				#somme = somme des chiffres present sur la ligne "side"
			
				somme = row.inject(:+)
				if somme > max 
					max = somme
					position = i
					@orientation = false
				end
				i+=1
			end
		
			# calcule le max sur les colonne
			for col in top do
				#somme = somme des chiffres present sur la colonne "top"
				somme = col.inject(:+)
				if somme > max 
					max = somme
					position = j
					@orientation = true
				end
				j+=1
			end
		
			
			# affiche le plus gros chiffre avec son indice si c'est une ligne 
			if !@orientation
				@indice = ("La ligne #{position} possede le plus gros chiffre qui est #{max}\n")
			end
		
			# affiche le plus gros chiffre avec son indice si c'est une colonne 
			if @orientation
				@indice = ("La colonne #{position} possede le plus gros chiffre qui est #{max}\n")
			end

		else
			puts( "Nombre d'utilisation maximum de cet indice atteint." )
		end
		
		return self
		
	end


end

	
	voila = IndiceFaible.new
	print voila.envoyerIndice.indice

	
	
	
	
	
	