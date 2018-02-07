load "Case.rb"
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
  # * side : Tableau des chiffres sur le coté
  # * top : Tableau des chiffres du dessus
  # * res : matrice de résultat(pour comparaison)

  private_class_method :new

############################## CRÉATION ##############################
##
# Constructeur de la classe
#
# Param :
# * filename : Nom du fichier de resultat
	def initialize(filename)

    @side = Array.new()
    @top = Array.new()
    @res = Array.new()
    @filename = filename
    self.import
    @rows=@res.length
    @cols=@res[0].length
    self.generateSide()
    self.generateTop()
    @map = Array.new(@rows){Array.new(@cols)}
    self.empty

	end
##
# Création de la Grille
  def Map.create(filename)
    new(filename)
  end

#####################################################################



###################### GETTERS #################################
##
# Getter du tableau de case
#
# Retourne le tableau
    def getMap()
      return @map
    end
##
# Getter de top
#
# Retourne @top
    def getTop
      return @top
    end
##
# Getter de side
#
# Retourne @side
    def getSide
      return @side
    end

##
# Getter de cols
#
# Retourne @cols
    def getCols
      return @cols
    end
##
# Getter de rows
#
# Retourne @rows
    def getRows
      return @rows
    end
##############################################################




################################## REMPLISSAGE DES VARIABLES D'INSTANCE ########################

##
# Rempli la matrice de case vides
#
# Retourne nil
	def empty
    # On itère dans la matrice comme en C de 0 à Nb colonne -1 (Faut faire gaffe au -1)
		0.upto(@rows-1) do |row|
			0.upto(@cols-1) do |col|
				@map[row][col] = Case.create(0)
			end
		end
    return nil
	end
##
# Génère la liste de chiffre sur le coté
#
# Retourne nil
  def generateSide
    count = 0
    for row in @res do
      lign = Array.new()
      for num in row do
        if num == 1
          count +=1
        end
        if (num == 0 && count != 0 )
          lign.push(count)
          count=0
        end
      end
      if (count != 0 )
        lign.push(count)
        count=0
      end
      @side.push(lign)
    end
    return nil
  end
##
# Génère la liste de chiffre sur le coté
#
# Retourne nil
  def generateTop
    count = 0
    0.upto(@cols -1) do |num|
      lign = Array.new()
      for tab in @res do
        if tab[num] == 1
          count +=1
        end
        if (tab[num] == 0 && count != 0 )
          lign.push(count)
          count=0
        end
      end
      if (count != 0 )
        lign.push(count)
        count=0
      end
      @top.push(lign)
    end
  end
##
# Importe un fichier au format texte en tableau de resultat
#
# Si le fichier n'existe pas ça plante, il faut mettre le chemin relatif
  def import ()
    fd=File.open(@filename,'r')
    fd.each_line do |x|
      lign=Array.new()
      x.split(//).each do |char|
        lign.push(char.to_i)
      end
      @res.push(lign)
    end
  end
################################################################################################






################################### GESTION DES CASES #########################################
##
# Accède à une case de la grille en mode <b>LIGNE COLONNE</b>
#
# Param :
# * row : Ligne à acceder
# * col : Colonne à acceder
# Retourne la case de la grille EN LECTURE SEULE (pas touche)

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
# Retourne nil
  def putAt!(row,col,value)
    @map[row][col]=value
    return nil
  end

################################################################################################

##
# Vérifie que deux grille sont égales
#
# Param : Map à comparer (La classe, pas le tableau)
#
# Retourne un booléen true si égales, false sinon
  def compare(res)
    0.upto(@rows-1) do |row|
			0.upto(@cols-1) do |col|
				if self.accessAt(row,col).verifColor != res.accessAt(row,col).verifColor
          return False
        end
			end
		end
    return True
  end





##
# Affiche la grille
#
# Retourne nil
  def display

    i=0
    print "   "
    0.upto(9) do |x|
      print" #{x} "
    end
    10.upto(@cols-1) do |x|
      print" #{x}"
    end
    print "\n"
    print "  "
    0.upto(@cols-1) do
      print"---"
    end
    print "\n"
    0.upto(9) do |x|
 		  print " #{x} #{@res[x]}\n"
 		end
    10.upto(@rows-1) do |x|
      print "#{x} #{@res[x]}\n"
    end
    return nil
	end


end #Fin de Classe

map = Map.create("./scenario_bateau")
map.display
