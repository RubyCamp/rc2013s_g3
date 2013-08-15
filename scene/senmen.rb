# coding: UTF-8

#洗面台用のクラス

class Senmen
	def initialize
		@bg_image = Image.load("images/senmen.png")
		@suiteki = Image.load("images/suiteki.png")
		@suiteki.setColorKey([255,255,255])
		@waters = []
		10.times do
			@waters << Suiteki.new(rand(350) + 113,rand(230) + 160,@suiteki)
		end
		@zoukin_image = Image.load("images/zoukin.png")
		@zoukin = Sprite.new(88,551,@zoukin_image)
		@hit = Sprite.new(0,0)
		@hit.collision = [400,0,480,640]
		@migihaji = Shoutotu.new("door")
		@migihaji.collision = [440,0,480,640]
		@pointer = Sprite.new(0, 0)
   	@pointer.collision = [-18, -27, 18, 27]
		@click_flag = 0
                @i_migihaji = Image.load("images/arrow_right.png")
                @i_migihaji.setColorKey([255,255,255])
           	@hukihuki = Sound.new("sounds/hukihuki.wav") #音声読み込み
                @hukihuki.setVolume(255,0)
	end

	def play
		@pointer.x = Input.mousePosX
		@pointer.y = Input.mousePosY
		if Input.mousePush?(M_LBUTTON)
			# 現時点のマウス座標を取得し、ポインタオブジェクトの座標を更新
#			@pointer.x = Input.mousePosX
#			@pointer.y = Input.mousePosY
#			@migihaji.x = 0
#			@migihaji.y = 0
			Sprite.check(@pointer, @migihaji)
			if Sprite.check(@pointer,@zoukin)
				#雑巾画像がクリックされたらクリックフラグをオンし、ドラッグで画像がついてくるようにする。また雑巾の元画像を消す。
				@click_flag = 1
				@zoukin.visible = false
			end
		end
		
		Window.draw(0,0,@bg_image)
		Sprite.draw(@waters)
		Sprite.clean(@waters)
		Sprite.draw(@zoukin)
		@waters.compact!
		if @waters.size == 0
			$suiteki = true
			@clear_flag = 1
		end

                if Sprite.check(@pointer,@hit)
                  Window.draw(440,0,@i_migihaji)
                end

		if Input.mouseDown?(M_LBUTTON) && @click_flag == 1
			x = Input.mousePosX  # マウスカーソルのx座標
			y = Input.mousePosY

			Window.draw(x - 30,y - 40,@zoukin_image)
			@pointer.x = x
			@pointer.y = y
			if Sprite.check(@pointer, @waters)				
		                @hukihuki.play #音声on
			end
		else
			#マウスボタンが離されたらフラグをオフし、雑巾画像を見えるようにする。
			@click_flag = 0
			@zoukin.visible = true
		end

		# 現時点のマウス座標を取得し、ポインタオブジェクトの座標を更新
		
	end

end

class Suiteki < Sprite
	def vanished?
		return @vanished
	end

	def hit(obj)
		@vanished = true
	end

end
