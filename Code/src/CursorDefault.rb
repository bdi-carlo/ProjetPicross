begin
 require 'rubygems'
 rescue LoadError
end
require 'gtk3'
##
# Classe représentant un curseur par défaut
class CursorDefault

	@@instance = nil

	private_class_method :new

	def CursorDefault.getInstance()
		if @@instance == nil
			@@instance = Gdk::Cursor.new("default")
		end
		return @@instance
	end

end
