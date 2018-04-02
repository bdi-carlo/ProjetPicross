allSaves = Dir.entries("../sauvegardes")
allSaves.delete(".")
allSaves.delete("..")
allSaves.each{ |elt|
	tmp = elt.split('_')
	if tmp[0] == "test"
		puts tmp[1]
	end
}
