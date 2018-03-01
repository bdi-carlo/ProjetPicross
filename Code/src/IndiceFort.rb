load "Indice.rb"
load "Map.rb"

class IndiceFort < Indice


	def initialize
		@penalites = 120
		@map = Map.create("scenario_bateau")
		@nbMax = 1
	end
	
	##
	#indique si la prochaine case colorie est bonne ou non
	#
	def Indice
		
	end
end
