class Mbox < Sprite
	@@message = ""
	Mbox_x = 20
	Mbox_y = 512

	def set_message(msg)
		@@message = msg
	end

	def draw
		font = Font.new(20)
		Window.drawFont(Mbox_x + 20, Mbox_y + 20, @@message, font, hash = {:color => [0, 0, 0]})
	end

	def clear
		@vanished = true
	end
end
