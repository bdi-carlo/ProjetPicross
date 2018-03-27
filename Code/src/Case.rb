# encoding: UTF-8
##
# Classe représentant une case de la grille
class Case

  # valeur d'une case: 0 = blanc, 1 = noir, 2 = barré
	@value
	attr_accessor :value
	attr_accessor :color

	def initialize(val)
		@value = val
	end

	private_class_method :new

	def Case.create(val)
		new(val)
	end

  ##
	# Getter de couleur de la case avec les blanc et les barrés pareil
  #
  # Retour : couleur de la case, colorié ou non
  def verifColor
    if @value == 1
      return @value
    end
    if @value == 0
      return 0
    end
    if @value == 2
      return 0
    end
  end
  def

  ##
  # redéfinition de l'affichage
	def to_s
		if @value==0
      return " "
    elsif @value==1
      return "■"
    elsif @value==2
      return "x"
    end
	end

end # Marqueur de fin de classe
