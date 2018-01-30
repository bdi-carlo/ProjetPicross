require "yaml"

=begin

maSauvegarde = Save.new([...])
[...]
donnee = objet.to_yaml()
[...]
objet = YAML.load(donnee)


=end



class Save

	
	@nomSave
	@grille




	def Save.creer(unPseudo, unMode, uneDiff, uneDate, uneGrille)
		new(unPseudo, unMode, uneDiff, uneDate, uneGrille)
	end

	private_class_method:new

	def initialize(unPseudo, unMode, uneDiff, uneDate, uneGrille)
		@nomSave = unPseudo+"-"+unMode+"-"+uneDiff+"-"+uneDate+"-"+uneGrille
		@grille = uneGrille
	end




	
	def sauvegarder(param)
	end

	def charger()

		
		return grille
	end

	def to_s()
		return @nomSave
	end



end


	
