module Util
	Black = [0, 0, 0]
	White = [255, 255, 255]
   @@flag = 0 
   Mbox_X = 20
   Mbox_Y = 512

	module_function
# 	引数で指定した画像をimagesディレクトリから読み込む
	def load_image(filename)
		return Image.load(File.join(File.dirname(__FILE__), "..", "images", filename))
	end

   def message(message)
      @@mbox_img = Util.load_image("mbox.png")
      @@mbox = Sprite.new(Mbox_X, Mbox_Y, @@mbox_img)
      @@font = Font.new(20)
      @@mbox.draw
      Window.drawFont(Mbox_X + 20, Mbox_Y + 20, message, @@font)
   end

	def show_message(message)
		mbox_img = Util.load_image("mbox.png")	
		@mbox = Sprite.new(Mbox_X, Mbox_Y, mbox_img)	
       font = Font.new(20)
       if @@flag < 60 && @@flag > 0
       @mbox.draw
       Window.drawFont(Mbox_X + 20, Mbox_Y + 20, message, font, hash = {:color => [255, 255, 255]})
       @@flag += 1
       end
       @@flag = 0 if @@flag >= 60

# 		if Input.mousePush?(M_LBUTTON)
# 			mbox.click
# 		end

#     mbox.draw if mbox.flag
	end

   def flag
      return @@flag
   end
end

=begin
class Mbox < Sprite
  Mbox_X = 20
  Mbox_Y = 512
  @@flag = true
  @@message = "" 
  @@count = 0
  @@scene

  def flag
    return @@flag
  end

  def initialize(scenes)
    @@scene = scenes
  end

  def set_message(msg)
    @@message = msg
  end

  def draw
    @@count = 0 if @@count >= 10
  end

  def click
    puts @@scene.clicked
    @@flag = false
      if @@scene.clicked
         puts "clicked!"
          @@count += 1
      end
    @@flag = true if @@count % 2 == 0
    @@scene.cur_message = nil if @@flag == false    
  end
end
=end
