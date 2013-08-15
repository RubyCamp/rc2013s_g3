# coding: UTF-8

class Door
   Mbox_X = 20
   Mbox_Y = 512
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
      @to_senmen_img = Util.load_image("arrow_left.png")
      @to_senmen_img.setColorKey([255, 255, 255])
      @to_senmen_obj = Sprite.new(0, 0, @to_senmen_img)
      @to_kinko_img = Util.load_image("arrow_right.png")
      @to_kinko_img.setColorKey([255, 255, 255])
      @to_kinko_obj = Sprite.new(440, 0, @to_kinko_img)
      @to_zentai_img = Util.load_image("arrow_down.png")
      @to_zentai_img.setColorKey([255, 255, 255])
      @to_zentai_obj = Sprite.new(40,600, @to_zentai_img)
      @item_box = Sprite.new(0,0) # アイテムボックスのスプライト
      @item_box.collision = [440, 0, 540, 640] # アイテムボックスの衝突判定
      @gasa = Sound.new("sounds/gasa.wav")
      @gasa.setVolume(255,0)
      @doornobu = Sprite.new(0,0)
      @doornobu.collision = [91,99,282,544]
      @doorgacha = Sound.new("sounds/doorgacha.wav")
      @doorgacha.setVolume(255)
      @doorake = Sound.new("sounds/doorake.wav")
      @doorake.setVolume(255)
      @@flag_door = 90
      @mask_img = Util.load_image("mask.png")
      @mask = Sprite.new(388, 276, @mask_img)
      @@flag_air = 90
      @@flag_light = 90
      @@flag_air_switch = 90
      @pi = Sound.new("sounds/pi.wav")
   end
   
   def play
      Window.draw(0, 0, @door_img)
      Sprite.draw(@door_c)
      Sprite.draw(@shoes) unless $shoes_get_flag == 1
      Sprite.draw(@mask) if !$air_flag
      @pointer.x = Input.mousePosX
      @pointer.y = Input.mousePosY

         if Input.mousePush?(M_LBUTTON)
            @pointer.x = Input.mousePosX
            @pointer.y = Input.mousePosY
              if Sprite.check(@pointer, @door_c)
               if $surippa && $huton_r && $huton_l && $door && $suiteki && !$air_flag && $souji && $gomi1 && $gomi2 && $gomi3
                  Director.change_scene(:ending)
                  $clear_flag = 1
                  @doorake.play
               else
                  @@flag_door = 0
                  @doorgacha.play
               end
            end
            if !Sprite.check(@pointer, @door_c) &&
               @pointer.x >= 317 && @pointer.x <= 334 &&
               @pointer.y >= 257 && @pointer.y <= 285 then
                  @@flag_light = 0
            end
            if !Sprite.check(@pointer, @door_c) &&
               Sprite.check(@pointer, @mask) then
                  if $air_flag
                     $air_flag = false
                  @pi.play
                  else
                     $air_flag = true
		  @pi.play
                  end
                  @@flag_air_switch = 0
            end
            if !Sprite.check(@pointer, @door_c) &&
               !Sprite.check(@pointer, @mask) &&
               @pointer.x >= 387 && @pointer.x <= 415 &&
               @pointer.y >= 259 && @pointer.y <= 287 then
                  @@flag_air = 0
            end
         end


         if Input.mousePush?(M_LBUTTON)
            @pointer.x = Input.mousePosX
            @pointer.y = Input.mousePosY
            if Sprite.check(@pointer,@shoes) && $shoes_get_flag == 0
               @shoes_flag = 1
               @shoes.visible = false
               @gasa.play #音声on
            elsif Sprite.check(@pointer, @to_senmen_obj)
               Director.change_scene(:senmen)
            elsif Sprite.check(@pointer, @to_kinko_obj)
               Director.change_scene(:kinko)
            elsif Sprite.check(@pointer, @to_zentai_obj)
               Director.change_scene(:zentai)
            end
         end

         if Sprite.check(@pointer,@to_senmen_obj) && @shoes_flag == 0
            Window.draw(0,0,@to_senmen_img)
         elsif Sprite.check(@pointer,@to_kinko_obj) && @shoes_flag == 0

            Window.draw(440,0,@to_kinko_img)
         elsif Sprite.check(@pointer,@to_zentai_obj) && @shoes_flag == 0

            Window.draw(40,600,@to_zentai_img)
         end

         if Input.mouseDown?(M_LBUTTON) && @shoes_flag == 1
            x = Input.mousePosX  # マウスカーソルのx座標 
            y = Input.mousePosY 
            @moji_flag = 1
            Window.draw(x,y,@shoes_img) if $shoes_get_flag == 0
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
         if @@flag_door < 60
            Util.message("まだ開かない。")
            @@flag_door += 1
         end
         if @@flag_light < 60
            Util.message("電気のスイッチがある。\n特に押す必要はない。")
            @@flag_light += 1
         end
         if @@flag_air < 60
            Util.message("エアコンのリモコンパネルがある。")
            @@flag_air += 1
         end
         if @@flag_air_switch < 60
            Util.message("エアコンのスイッチを入れた。") if $air_flag
            Util.message("エアコンのスイッチを切った。") if !$air_flag
            @@flag_air_switch += 1
         end
    end
end
