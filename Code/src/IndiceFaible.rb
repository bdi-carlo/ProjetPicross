load "Indice.rb"
load "Map.rb"

class IndiceFaible < Indice

# *VARIABLES D'INSTANCE*
  # * penalites : Un indice faible correspond à 15s de pénalité
  # * orientation : Choix entre ligne ou colonne
  # * nbUtilisation : Nombre d'utilisation de l'indice
  # * nbMax :  Un indice faible peut être utilisé au maximum 3 fois


	attr_reader :indice

	def initialize(grille)
		@penalites = 15
		@indice = nil
		@orientation = false
		@nbUtilisation = 0
		@nbMax = 3
		super(grille)
	end

##
# renvoie indice chaine de caractere contenant le plus gros chiffre "max" et sa position
#

	def envoyerIndice
		if @nbUtilisation < @nbMax
			@nbUtilisation += 1
			position = 0
			somme = 0
			max = 0
			side = @map.side
			top = @map.top
			i = 0
			j = 0

			# calcule le max sur les lignes
			for row in side do
				#somme = somme des chiffres present sur la ligne "side"

			  somme = row.inject(:+)
        if somme == nil
          somme = 0
        end
        
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

        if somme == nil
          somme = 0
        end
				if somme > max
					max = somme
					position = j
					@orientation = true
				end
				j+=1
			end


			# affiche le plus gros chiffre avec son indice si c'est une ligne
			if !@orientation
				@indice = "La ligne #{position+1} possede le plus gros chiffre qui est #{max}\n"
			end

			# affiche le plus gros chiffre avec son indice si c'est une colonne
			if @orientation
				@indice = "La colonne #{position+1} possede le plus gros chiffre qui est #{max}\n"
			end

		else
			@indice = "Nombre d'utilisation maximum de cet indice atteint."
		end

		return self

	end


end
=begin
	map = Map.create("../grilles/scenario/Bateau")
	voila = IndiceFaible.new(map)
	print "#{voila.envoyerIndice.indice}\n"

	"../grilles/Scenario/Bateau"
=end
