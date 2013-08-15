# coding: UTF-8

class Kinko
	def initialize
# 		door...ドア
# 		safe...金庫
#     bacm...掃除機
# 		c...closed
# 		o...opened
# 		hit...当たり判定
		@dc_sc_bc_img = Util.load_image("kinko_dc_sc_bc.png") 
		@dc_sc_bo_img = Util.load_image("kinko_dc_sc_bo.png") 
		@do_sc_bc_img = Util.load_image("kinko_do_sc_bc.png") 
		@do_sc_bo_img = Util.load_image("kinko_do_sc_bo.png") 
		@do_so_bo_img = Util.load_image("kinko_do_so_bo.png") 
		@do_so_bc_img = Util.load_image("kinko_do_so_bc.png") 

		@hit_door_img = Util.load_image("kinko_hit_door.png")
		@hit_door = Sprite.new(34, 167, @hit_door_img)
#       @hit_door.collision = ([34, 167, 34 + 252, 167 + 372])

		@hit_safe_img = Util.load_image("kinko_hit_safe.png")
		@hit_safe = Sprite.new(73, 444, @hit_safe_img)
#       @hit_safe.collision = ([73, 444, 73 + 99, 444 + 67])

		@hit_bacm_img = Util.load_image("kinko_hit_bacm.png")
		@hit_bacm = Sprite.new(291, 169, @hit_bacm_img)
#       @hit_bacm.collision = ([291, 169, 291 + 120, 169 + 365])

		@to_door_img = Util.load_image("arrow_left.png")
      @to_door_img.setColorKey([255, 255, 255])
		@to_door = Sprite.new(0, 0, @to_door_img)
               

		@pointer = Sprite.new(0, 0)
		@pointer.collision = [0, 0, 1]

		@current_bg = @dc_sc_bc_img
                @dooro = Sound.new("sounds/dooropen.wav") #ドアオープンのサウンド読み込み
                @doorc = Sound.new("sounds/doorclose.wav") #ドアクローズのサウンド読み込み
                @safeo = Sound.new("sounds/safeopen.wav") #金庫オープンのサウンド読み込み
                @safec = Sound.new("sounds/safeclose.wav") #金庫クローズのサウンド読み込み

                @i_hidarihaji = Image.load("images/arrow_left.png")
                @i_hidarihaji.setColorKey([255,255,255])
                @hidarihaji = Sprite.new(0,0)
                @hidarihaji.collision = [0,0,40,640]

                @souji_hit = Sprite.new(0,0)
                @souji_hit.collision = [330,460,360,490]

                @i_souji = Image.load("images/souji.png")
                @i_souji.setColorKey([255,255,255])
                @souji = Sprite.new(330,460,@i_souji)
                @souji.visible = false
                @souji_flag = 0


                @souji_after = Sprite.new(330,460,@i_souji)
                @souji_after.visible = false
                
                @item_box = Sprite.new(0,0) # アイテムボックスのスプライト
                @item_box.collision = [440, 0, 540, 640] # アイテムボックスの衝突判定

                @first = 1
                @@b_o_flag = 0
	end

	def play
		@pointer.x = Input.mousePosX
		@pointer.y = Input.mousePosY
		if Input.mousePush?(M_LBUTTON)
#			@pointer.x = Input.mousePosX
#			@pointer.y = Input.mousePosY
			if Sprite.check(@pointer, @to_door)
#				if @current_bg == @c_door_img
				Director.change_scene(:door)
#				end
			end

			if Sprite.check(@pointer, @hit_safe) #金庫
				case @current_bg
				when @do_sc_bc_img #金庫開く
				@current_bg = @do_so_bc_img
                                @safeo.play #サウンドon
				$door = true
				when @do_so_bc_img #金庫開く
				@current_bg = @do_sc_bc_img
                                @safec.play #サウンドon
				$door = false
				when @do_sc_bo_img #金庫開く
				@current_bg = @do_so_bo_img
                                @safeo.play #サウンドon
				$door = true
				when @do_so_bo_img #金庫開く
				@current_bg = @do_sc_bo_img
                                @safec.play #サウンドon
				$door = false
				end
			elsif Sprite.check(@pointer, @hit_door) #タンス
				case @current_bg
				when @dc_sc_bc_img #タンス開く
                               	   @dooro.play #サウンドon
				   @current_bg = @do_sc_bc_img
				   $door = false
				when @do_sc_bc_img #タンスとじる
                                   @doorc.play #サウンドoff
			           @current_bg = @dc_sc_bc_img
				   $door = false
				when @dc_sc_bo_img #開く
                               	   @dooro.play #サウンドon
				   @current_bg = @do_sc_bo_img
				   $door = false
				when @do_sc_bo_img #とじる
                                   @doorc.play #サウンドoff
			           @current_bg = @dc_sc_bo_img
				   $door = false
				end
			end


                        if Sprite.check(@pointer,@souji) && @@b_o_flag == 1# && $shoes_get_flag == 0
                          @souji_flag = 1
                          @souji.visible = false
                          @first = 0
			elsif Sprite.check(@pointer, @hit_bacm) #掃除機
				case @current_bg
				when @dc_sc_bc_img #掃除機開く
                               	   @dooro.play #サウンドon
				   @current_bg = @dc_sc_bo_img
				   $door = false
                                   @souji.visible = true
                                   @souji_after.visible = true
                                   @@b_o_flag = 1
				when @dc_sc_bo_img #掃除機とじる
                                   @doorc.play #サウンドoff
			           @current_bg = @dc_sc_bc_img
				   $door = false
                                   @souji.visible = false
                                   @souji_after.visible = false
                                   @@b_o_flag = 0
				when @do_sc_bc_img #掃除機開く
                               	   @dooro.play #サウンドon
				   @current_bg = @do_sc_bo_img
				   $door = false
                                   @souji.visible = true
                                   @souji_after.visible = true
                                   @@b_o_flag = 1
				when @do_sc_bo_img #掃除機とじる
                                   @doorc.play #サウンドoff
			           @current_bg = @do_sc_bc_img
				   $door = false
                                   @souji.visible = false
                                   @souji_after.visible = false
                                   @@b_o_flag = 0
				when @do_so_bc_img #掃除機開く
                               	   @dooro.play #サウンドon
				   @current_bg = @do_sc_bo_img
				   $door = false
                                   @souji.visible = true
                                   @@b_o_flag = 1
				when @do_so_bo_img #掃除機とじる
                                   @doorc.play #サウンドoff
			           @current_bg = @do_sc_bc_img
				   $door = false
                                   @souji.visible = false
                                   @@b_o_flag = 0
				end
			end
		end

		Window.draw(0, 0, @current_bg)

                if Input.mouseDown?(M_LBUTTON)  && @souji_flag == 1 && @@b_o_flag == 1
                  Window.draw(@pointer.x - 20,@pointer.y - 20,@i_souji)  unless $souji_get_flag == 1
                  if Sprite.check(@pointer,@item_box)
                    $souji_get_flag = 1
                  end
                elsif @first == 0
                  @souji_flag = 0
                  @souji.visible = true
                  @first = 1
                end


                if $global_click_flag_s == 1 && $gomi1 && $gomi2 && $gomi3
                  if Sprite.check(@pointer,@souji_hit)
                    $souji = true
                    $item_lost_souji = true
                  end
                end
                
                Sprite.draw(@souji) unless $souji_get_flag == 1
                Sprite.draw(@souji_after) if $item_lost_souji == true
                
                if Sprite.check(@pointer,@hidarihaji)
                  Window.draw(0,0,@i_hidarihaji)
                end
	end
end
