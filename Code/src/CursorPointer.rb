begin
 require 'rubygems'
 rescue LoadError
end
require 'gtk3'

##
# Classe représentant un curseur sur un objet cliquable
class CursorPointer

	@@instance = nil

	private_class_method :new

	def CursorPointer.getInstance()
		if @@instance == nil
			@@instance = Gdk::Cursor.new("pointer")
		end
		return @@instance
	end

end
