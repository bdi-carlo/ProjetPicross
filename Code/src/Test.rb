
def recupNom( unString )
	res = ""
	unString.reverse.each_char{ |x|
		if x == '/'
			return res.reverse
		else
			res << x
		end
	}
	return res.reverse
end

print recupNom("../grilles/10x10/Neuf")
