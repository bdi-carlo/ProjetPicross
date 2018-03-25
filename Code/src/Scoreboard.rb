

begin
  require 'rubygems'
 rescue LoadError
end

require 'gtk3'
load "Map.rb"
load "Case.rb"
load "Timers.rb"
#load'Score.rb'
load "IndiceFaible.rb"
load "IndiceMoyen.rb"

class ScoreBoard

  	@score 		#score joueur
  	@highscore	#meilleur score dur joueur
  	@nom_fichier #le nom de la map
    @@nomFichier = "../sauvegardes/Score.txt" #fichier score
    @difficulte
  	attr_accessor :pseudo,:difficulte,:penalite,:score,:highscore,:taille,:nom_fichier

    def initialize()
        ten_best_hs("HARD", "Cobra")
    end

    def ten_best_hs(unNom,uneMap)

      tabScores = Array.new()
      toDel = Array.new()
      nvxtab = Array.new()
      nvxtab2 = Array.new()


      # On remplie un tableau avec les scores du fichier
      f = File.open(@@nomFichier, "r")
      f.each_line do |line|
        tabScores.push("#{line}")
      end
      f.close()

      # On garde que les lignes correspondants a la grille/nom/difficulte/etc

      tabScores.uniq.sort.each do |score|
        if (score.include?(unNom) && score.include?(uneMap) )
          nvxtab.push(score) if (nvxtab.size < 10)
        end
      end

      p "tabScores : "
      for i in  tabScores
        print i
      end

      p "nvxtab : "
      for i in nvxtab
        print i
      end

      ## On trie le tableau en fonction des score, on l'affiche et on le renvoie
      #
=begin
      tabScoresSorted = Array.new()
      for score in tabScores
        tabScoresSorted.push(score.split(/ /))
      end

      t = tabScoresSorted.sort_by(&:first).first
      scoreRes = t[0]+" "+t[1]+" "+t[2]+" "+t[3]
      print "----- HIGHSCORE de "+unNom+" -----\n- "+scoreRes+"\n"
=end

      #return scoreRes
      #tabScoresSorted.sort_by(&:first).first

      return tabScores

    end


end

ScoreBoard.new()
