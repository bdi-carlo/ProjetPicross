load "Map.rb"

require "yaml.rb"

class Hypothese
# Ici une Hypothese c'est une grille à partir de laquelle on va faire des hypothèses et un tableau contenant une multitude de grilles hypothétiques.
# On peut faire des hypothèses.
# On peut valider une hypothèse ou la rejeter.

 	#  *VARIABLES D'INSTANCE*
	# * grillePrim : Grille originale
	# * grillesHypothese : Tableau de grilles suite à l'entrée en hypothese(s)

	def initialize(uneGrille)
		@grillePrim=uneGrille
		@grillesHypothese = Array.new()
	end

	private_class_method :new

	##
	# Constructeur de la classe ( sujet à modifications )
	#
	def Hypothese.creer(uneGrille)
		new(uneGrille)
	end

	##
	# Creer une hypothese
	#
	# Retour : grille sur laquelle le jeu va "travailler"
	def faireHypothese()

		if @grillesHypothese.empty?
			newGrille = YAML.load(@grillePrim.to_yaml)
			@grillesHypothese.push(newGrille)
		else
			newGrille = YAML.load(@grillesHypothese.last.to_yaml)
			@grillesHypothese.push(newGrille)
		end

		return @grillesHypothese.last
	end

	##
	# Valide la derniere hypothese
	#
	def validerHypothese()
		tmp=@grillesHypothese.pop
		@grillesHypothese.pop
		@grillesHypothese.push(tmp)
		return @grillesHypothese.last
	end

	##
	# Rejete la derniere hypothese
	#
	def rejeterHypothese()
		@grillesHypothese.pop

		if @grillesHypothese.empty?
			return @grillePrim
		else
			return @grillesHypothese.last
		end
	end

	##
	# Clear la tableau d'hypothese
	#
	def resetHypothese()
		@grillesHypothese.clear
	end

	##
	# Retourne le nombre d'hypothses faites
	#
	def nbHypotheses()
		return @grillesHypothese.count
	end

end

=begin
	map = Map.create("../grilles/Test2x2")
	hyp = Hypothese.creer(map)

	print "\n\n-------------------------------------------\n"
	print "Chiffres du dessus :\n"
	print "#{map.top}\n"
	print "Chiffres du cote :\n"
	print "#{map.side}\n"
	print "Nombre de colonnes :\n"
	print "#{map.cols}\n"
	print "Nombre de lignes :\n"
	print "#{map.rows}\n"
	print "Test de compare (erreur) : \n"

	if map.compare
	  print "Map Bonne\n"
	else
	  print "Map Fausse\n"
	end
	print "Correction de la grille :\n"

	map.putAt!(1,0,Case.create(1))

	map = hyp.faireHypothese

		map = hyp.faireHypothese
		map.putAt!(1,0,Case.create(0))
		map = hyp.rejeterHypothese

	map.putAt!(0,1,Case.create(1))

	map = hyp.validerHypothese

	if map.compare
	  print "Map Bonne\n"
	else
	  print "Map Fausse\n"
	end

	map.display
=end
