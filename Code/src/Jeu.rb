##
# Classe Jeu abstraite qui peut lancer une partie sur une grille
# 4 Variables d'instances.
#

class Jeu

    @temps
    @difficulte
    @pseudo
    attr_accessor :pseudo,:difficulte,:taille

    #private_class_method :new

    ##
    # Constructeur qui rappelle que l'on ne peut pas instancier cette classe
    #

    def initialize()
        #@difficulte = setDifficulte()
        #@taille = setTaille()
    end

    ##
    # Méthode qui permet de lancer le jeu
    #
    #


=begin partie methodes hypotheses

	##
	# Commence hypothese
	#
	def hypotheser()

	end

=end

end
