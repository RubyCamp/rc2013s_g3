# coding: UTF-8

class Door
	def initialize
		@door_img = Util.load_image("../images/door.png")
		@door_c_img = Util.load_image("../images/door_c.png")
		@shoes_img = Util.load_image("../images/shoes.png")
		@pointer = Sprite.new(0, 0)
        @door_c = Sprite.new(107,106,@door_c_img)
        @shoes =Sprite.new(159,596,@shoes_img)
        @pointer.collision = [0, 0, 1]
        @font = Font.new(32)
        @image =  Image.load("images/title.png")
        @dragging = false
        @shoes_flag = 0
        @moji_flag = 0
	@to_senmen_img = Util.load_image("smile.png")
	@to_senmen_img.setColorKey([255, 255, 255])
	@to_senmen_obj = Sprite.new(0, 0, @to_senmen_img)
	@to_kinko_img = Util.load_image("smile2.png")
	@to_kinko_img.setColorKey([255, 255, 255])
	@to_kinko_obj = Sprite.new(430, 230, @to_kinko_img)
        @item_box = Sprite.new(0,0) # アイテムボックスのスプライト
        @item_box.collision = [440, 0, 540, 640] # アイテムボックスの衝突判定
    end
    def play
        Window.draw(0, 0, @door_img)
        Sprite.draw(@door_c)
        Sprite.draw(@shoes) unless $shoes_get_flag == 1


            if Input.mouseDown?(M_LBUTTON) && @moji_flag == 0
                @pointer.x = Input.mousePosX
        	    @pointer.y = Input.mousePosY
        	   if Sprite.check(@pointer, @door_c)
                 Window.draw_font(150, 300, "まだあきません",@font)
                end
            end

            if Input.mousePush?(M_LBUTTON)
                @pointer.x = Input.mousePosX
                @pointer.y = Input.mousePosY
                if Sprite.check(@pointer,@shoes) && $shoes_get_flag == 0
                    @shoes_flag = 1
                    @shoes.visible = false
		elsif Sprite.check(@pointer, @to_senmen_obj)
			Director.change_scene(:senmen)
		elsif Sprite.check(@pointer, @to_kinko_obj)
			Director.change_scene(:kinko)
                end
            end
            if Input.mouseDown?(M_LBUTTON) && @shoes_flag == 1
                x = Input.mousePosX  # マウスカーソルのx座標 
                y = Input.mousePosY 
                @moji_flag = 1
                Window.draw(x,y,@shoes_img) unless Sprite.check(@pointer,@item_box)
                 @pointer.x = Input.mousePosX 
                 @pointer.y = Input.mousePosY 
                if Sprite.check(@pointer,@item_box)
                  $shoes_get_flag = 1
                end
                else  #マウスボタンが離されたらフラグをオフし、スリッパ画像を見えるようにする。 
                @shoes_flag = 0
                @moji_flag = 0
                @shoes.visible = true
            end
             
    end
 
end





