load 'Map.rb'
load 'Jeu.rb'

class JeuCompetitif < Jeu

	#@temps		#temps par partie qui va permettre de donner un score

	#@pseudo 	#pseudo du joueur

	#@penalite	#penalite ajouter au score apres avoir utiliser une aide
	#@score 		#score joueur

	#@message	
	attr_accessor :pseudo,:message,:temps,:score

	private_class_method :new

	def JeuCompetitif.lanceToi()
		super()
	end

	def initialize()
		super
		print "pseudo : #{@pseudo} \n"
	
		num = 0
		#a changer celon les futurs nom des fichiers
		while num < 5 # voir en fonction du nombre de map a mettre dans l'entrainement
			nom = "./grilles/Entrainement/#{num}"
			Gui.new("nom",1,0)
			envoyerMessage(num)
			num += 1
		end

		
	end

	def envoyerMessage(num)
		case num
			when 1	#en fonction du nombre de map entrainement
				@message = "#{@pseudo} essaye de"	#rajouter instruction a afficher celon la map
			when 2
				@message = "#{@pseudo} essaye de"
			when 3
				@message = "#{@pseudo} essaye de"
			when 4
				@message = "#{@pseudo} essaye de"
			when 5
				@message = "#{@pseudo} essaye de"
			else
				@message = "alors la ya un probleme"
			end
	end
	
	def enregistreScore()
		@score = @temps + @penalite + @difficulte
		if(@score > @highscore)
			print "YEAH YEAH"
		end
	end
end


j = JeuCompetitif.lanceToi()
