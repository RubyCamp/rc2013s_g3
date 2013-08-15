# coding: UTF-8

#右側のベッド用クラス

class Rbed
	def initialize
		@image1 = Image.load("images/rbed_before.png")
		@image2 = Image.load("images/rbed_after.png")
		@i_kaaten = Image.load("images/kaaten.png")
		@i_kaaten.setColorKey([255, 255, 255])
		@i_huton = Image.load("images/futon.png")
=begin
		@image3 = Image.load("images/")
		@image4 = Image.load("images/")
		@image5 = Image.load("images/")
		@image6 = Image.load("images/")
		@image7 = Image.load("images/")
=end
		@pointer = Sprite.new(0, 0)
   	@pointer.collision = [0, 0, 1]
		@hidarihaji = Shoutotu.new("zentai")
		@hidarihaji.collision = [0,0,50,640]
		@haji = Sprite.new(0,0) #全体に戻る左端のリンク
# 		@haji.collision = [0,0,50,640] 
    @haji.image = Image.load("images/arrow_left.png") #全体に戻るリンクに矢印の画像を貼る
                @haji.x = 0 #矢印画像の位置
                @haji.y = 0 #矢印画像の位置
             #  @haji.z = 100
                @haji.image.setColorKey([255,255,255]) #画像の背景を透明にする
		@huton = Sprite.new(150,310,@i_huton)
		@surippa = Sprite.new(0,0)
		@surippa.collision = [100,600,285,625]
		@hyouji_i = @image1
		@huton_x = 150
		@huton_y = 310
		@change_point_x = 0
		@hutontataku = Sound.new("sounds/hutontataku.wav")
		@gasa = Sound.new("sounds/gasa.wav")
		@hutontataku.setVolume(255)
		@gasa.setVolume(255)
      @@flag = 90
	end

	def play
		@pointer.x = Input.mousePosX
		@pointer.y = Input.mousePosY
		# 左マウスボタンクリック時の挙動
		if Input.mousePush?(M_LBUTTON)
			# 現時点のマウス座標を取得し、ポインタオブジェクトの座標を更新
#			@pointer.x = Input.mousePosX
#			@pointer.y = Input.mousePosY
			@haji.x = 0
			@haji.y = 0
			Sprite.check(@pointer, @hidarihaji)
			#@hutonクリックで、布団の位置を変更
			if Sprite.check(@pointer, @huton) then
				@hutontataku.play
				w = @huton_x
				@huton_x = @change_point_x
				@change_point_x = w
				if w == 150
					$huton_r = true
				else
					$huton_r = false
				end
         elsif !Sprite.check(@pointer, @huton) && !Sprite.check(@pointer, @hidarihaji) && !$surippa
            @@flag = 0
			end
			#スリッパにアイテムをドラッグしたらスリッパを補充。
		end

		if $global_click_flag == 1
			if Sprite.check(@pointer,@surippa) then
				@gasa.play
				@hyouji_i = @image2
				$surippa = true
				$item_lost_shoes = true
			end
		end

		Window.draw(0,0,@hyouji_i)
		Window.draw(@huton_x,@huton_y,@i_huton)
		Window.draw(0,140,@i_kaaten)
		if Sprite.check(@pointer,@haji)
	                @haji.draw
		end
   if @@flag < 60
      Util.message("何かが足りない気がする・・・")
      @@flag += 1
   end
	end
=begin

	def hit(obj)
		#クリックしたのが端だったら全体へ。
		if obj == @haji
			Director.change_scene(:zentai)
		end
	end
=end
end
