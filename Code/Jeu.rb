##
# Classe Jeu abstraite qui peut lancer une partie sur une grille
# 4 Variables d'instances.
#

class Jeu

    #@temps
    #@difficulte
    #@pseudo

    ##
    # Constructeur qui rappelle que l'on ne peut pas instancier cette classe
    #
    def initialize
        raise "Erreur: classe abstraite -> impossible à instancier"
    end

    ##
    # Méthode qui permet de lancer le jeu
    #
    #
    def lancerJeu()
        setPseudo()
    end

    ##
    # Méthode qui permet au joueur de rentrer son pseudo et le sauvegarder
    #
    def setPseudo()
        print "Pseudo: "
        @pseudo = gets.chomp
    end

end
