require 'facets/timer'

##
# Classe servant à manipuler un timer ou un minuteur (croissant ou décroissant)
#
# Elle dispose de deux constructeurs.
#
# Chaque constructeur doit être suivi d'un bloc contenant la fonction d'affichage(plus facile pour gtk)
#
# Chaque constructeur a comme premier paramètre la valeur d'incrémentation que l'on souhaite, en gros 1 ou -1
#
# Le second constructeur doit avoir également le temps de départ
#
# l'installation du gem se fait par "gem install facets"
    class Timers

      private_class_method :update

      def initialize(increment)
          @timers = Timer.new(1) { self.update{yield} }
          @time = 0
          @inc = increment
      end

      def initialize(increment,start)
          @timers = Timer.new(1) { self.update{yield} }
          @time = start
          @inc = increment
      end
      ##
      # Getter du temps, c'est ça qu'on affiche ou qu'on traite
      #
      # Retour : Le temps actuel
      def getTime()
        return @time
      end

      ##
      # Rafraichit la variable d'instance time et permet une commande(affichage) toute les secondes
      #
      def update
        @time +=@inc
        yield
        @timers.start
      end

      ##
      # Démarre le timer pour la première fois, peut éventuellement servir de reset
      #
      # Retour : nil
      def start
        @time =0
        @timers.start
        return nil
      end
      ##
      # Met le timer en pause
      #
      # Retour : nil
      def pause
        @timers.stop
        @time +=@inc
        #print "Pause au temps #{@time}\n"
        return nil
      end
      ##
      # Relance le timer à la valeur précédente
      #
      # Retour : nil
      def resume
        @timers.start
        return nil
      end
      ##
      # Ajoute une montant de temps(en secondes) au timer en cours d'execution
      #
      # Param : Temps à ajouter(en seconde)
      #
      # Retour : nil
      def add(temps)
        self.pause
        @time+=temps
        self.resume
        return nil
      end
      
    end
#Exemple (y'a pas le =begin et =end) :

=begin
time = Timers.new(1){print "#{time.getTime}\n"}          # Crée un nouveau timer qui affiche le temps toutes les secondes
time.start                                               # Démarre le timer
0.upto(15) do
  print "a\n"                                            # Affiche 15 chiffres
  sleep 1
end
time.pause                                               # Passe en pause
0.upto(15) do
  print "a\n"                                            # Refait 15 itération sans chiffres
  sleep 1
end
time.resume                                              # Relance le timer
0.upto(15) do
  print "a\n"                                            # Fait 15 itérations avec chiffres.
  sleep 1
end
=end
