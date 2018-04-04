begin
 require 'rubygems'
 rescue LoadError
end
require 'gtk3'

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
