##
# Classe représentant une Grille de Picross, elle est sous la forme d'une matrice de case.
class Map
  # Ces commentaires n'apparaissent pas dans la doc
  # Pour faire un retour à la ligne dans la rdoc, il faut sauter une ligne
  #
  # Comme ça, et ne pas oublier l'espace avant le commentaire (sinon c'est moche)

  # *VARIABLES D'INSTANCE*
  # * map : représente le tableau de tableau (matrice)
  # * rows : Représente le nombre de lignes de la grille
  # * cols : Représente le nombre de colonnes de la grille

  private_class_method :new
	##
  # Constructeur de la classe
  #
  # Param :
  # * x : Nombre de lignes
  # * y : Nombre de colonnes
	def initialize(x,y)
		@rows,@cols=x,y
		@map = Array.new(x){Array.new(y)}
	end
  ##
  # Création de la Grille
  def Map.create(x,y)
    new(x,y)
  end
  ##
  # Rempli la matrice de manière aléatoire entre 0 et 2
  # Retourne la grille
	def fillRand
		prng=Random.new
		i=0
		j=0
    # On itère dans la matrice comme en C de 0 à Nb colonne -1 (Faut faire gaffe au -1)
		0.upto(@rows-1) do |row|
			0.upto(@cols-1) do |col|
				@map[row][col] = prng.rand(3)
			end
		end
    return self
	end
##
# Accède à une case de la grille en mode <b>LIGNE COLONNE</b>
#
# Param :
# * row : Ligne à acceder
# * col : Colonne à acceder
# Retourne la case de la grille EN LECTURE SEULE

	def accessAt(row,col)
		return @map[row][col]
	end
##
# Modifie la valeur d'une case de la grille par la valeur en paramêtre ,format <b>LIGNE COLONNE</b>
#
# Param :
# * row : Ligne à acceder
# * col : Colonne à acceder
# * value : Nouvelle valeur
# Retourne la grille
  def putAt!(row,col,value)
    @map[row][col]=value
    return self
  end
##
# Affiche la grille
# Retourne nil
 	def display

    i=0
    print "  "
    0.upto(@cols-1) do |x|
      print" #{x} "
    end
    print "\n"
    print "  "
    0.upto(@cols-1) do
      print"---"
    end
    print "\n"
 		for row in @map do
 			print "#{i} #{row}\n"
      i+=1
 		end
    return nil
	end

end

test = Map.create(10,10)
test.fillRand
print "Test accessAt(5,6)  :  #{test.accessAt(5,6)}\n"
print "Test putAt!(5,6,8)\n"
test.putAt!(5,6,8)
print "Test accessAt(5,6)  :  #{test.accessAt(5,6)}\n"
test.display
