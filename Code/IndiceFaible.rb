class IndiceFaible < Indice
	@nbMax

	def initialize
		@penalites = 15
		@indice = nil
		@orientation = false
		@map = Map.create("scenario_bateau")
		@nbMax = 3
	end

##
# renvoie indice chaine de caractere contenant le plus gros chiffre "max" et sa position
#

	def afficherIndice
		if @nbUtilisation < @nbMax
			@nbUtilisation += 1
			somme = 0
			max = 0
			side = getSide()
			top = getTop()
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
				@indice = ("La ligne #{position} possède le plus gros chiffre qui est #{max}")
		
			# affiche le plus gros chiffre avec son indice si c'est une colonne 
			if @orientation
				@indice = ("La colonne #{position} possède le plus gros chiffre qui est #{max}")
		end

		else
			puts( "Nombre d'utilisation maximum de cet indice atteint." )
		end
		
	end

# getter sur indice chaine de caractere contenant le plus gros chiffre "max" et sa position
	def getIndice
		return @indice
	end
end
