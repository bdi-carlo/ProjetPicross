##
# Classe représentant une case de la grille
class Case

	@value


	def initialize(val)
		@value = val
	end

  ##
  # Colore une case de la couleur choisie, 0 = blanc, 1 = noir, 2 = barré
  #
  # Param : couleur à colorier
  #
  # Retour : nil
	def color(val)
		@value = val
    return nil
	end
  ##
  # Getter de couleur de la case
  #
  # Retour : couleur de la case
  def getColor
    return @value
  end
  def
  ##
  # redéfinition de l'affichage
	def to_s
		if @value==0
      return "Blanc"
    elsif @value==1
      return "Noir"
    elsif @value==2
      return "Croix"
    end
	end

end # Marqueur de fin de classe
