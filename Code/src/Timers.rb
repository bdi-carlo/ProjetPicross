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

			attr_reader :time

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
        if @time == nil
          @time = 0
        end
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
