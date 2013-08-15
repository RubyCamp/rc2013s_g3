# coding: UTF-8

# 部屋全体の管理用クラス
class Zentai
  

def initialize
  @image = Image.load("images/zentai.png")
#  @image_smile = Image.load("images/smile.png")
   $kaisi = Sound.new("sounds/004.mid")
   @kaisi_f = 0
  @pointer = Sprite.new(0, 0)
  @pointer.collision = [0, 0, 1]
# @kari = Shoutotu.new("title")
# @kari.collision = [10,263,70,449]

  @i_gomi1 = Image.load("images/gomi.jpg")
  @i_gomi2 = Image.load("images/gomi.jpg")
  @i_gomi3 = Image.load("images/gomi.jpg")

  @i_gomi1.setColorKey([255,255,255])
  @i_gomi2.setColorKey([255,255,255])
  @i_gomi3.setColorKey([255,255,255])

  @gomi1 = Sprite.new(60,500,@i_gomi1)
  @gomi2 = Sprite.new(60,550,@i_gomi2)
  @gomi3 = Sprite.new(400,480,@i_gomi3)

  @pointer = Sprite.new(0,0)
  @pointer.collision = [0,0,1]

  @r_bed = Shoutotu.new("rbed")  #結合チェック
  @r_bed.collision = [419, 266, 479, 477] #結合チェック
# @migihaji.collision = [419,266,479,277]
  @i_migihaji = Image.load("images/arrow_right.png")
  @i_migihaji.setColorKey([255,255,255])
  @i_hidarihaji = Image.load("images/arrow_left.png")
  @i_hidarihaji.setColorKey([255,255,255])
  @migihaji = Sprite.new(440,0,@i_migihaji)
#  @migihaji.collision = [419,266,479,477]	
  @hidarihaji = Sprite.new(0,0,@i_hidarihaji)
#  @hidarihaji.collision = [10,263,70,449]
  @l_bed = Shoutotu.new("lbed") #結合チェック
  @l_bed.collision = [10,263,70,449] #結合チェック
  @do_or = Shoutotu.new("door") #結合チェック
  @do_or.collision = [142,125,353,429] #結合チェック
  @@light = 0 # 高いほど画面が明るい
  @@first_flag = 0 #明るくなり始めるまでの長さ、初回フラグを兼ねる
  @message_test = Font.new(22,fontname="ＤＦ平成明朝体W3")
  @message_main = Font.new(15.5,fontname="ＤＦ平成明朝体W3")
  @x = 255
   @@flag_deskandchair = 90
   @@flag_air = 90
   @@flag_tel = 90
  @s_flag1 = 0
  @s_flag2 = 0
  @s_flag3 = 0
  @souji = Sound.new("sounds/souji.wav")
  @souji.setVolume(210)

end


def play
  @pointer.x = Input.mousePosX
  @pointer.y = Input.mousePosY
  # 初回のみボヤッと明かりを灯す演出
  if @@first_flag < 827       #ここで明るくなり始めるまでの長さを指定
    @@first_flag += 1
    Window.draw_font_ex(240,10,"某施設 XXX号室にて",@message_test,hash = {:alpha => @x,:edge => true,:edge_color => [127,0,0]})
    Window.draw_font_ex(310,40,"10:6 August",@message_test,hash = {:alpha => @x,:edge => true,:edge_color => [127,0,0]})
    Window.draw_font_ex(20,70,"今日はRuby合宿の最終日だ。",@message_main,hash = {:alpha => @x}) if @@first_flag >= 0
    Window.draw_font_ex(20,110,"私は退出準備の為に荷物を纏め、ドアノブに手をかけた。",@message_main,hash = {:alpha => @x})  if @@first_flag >= 78
    Window.draw_font_ex(20,150,"……が、扉はぴくりとも動く事は無かった。",@message_main,hash = {:alpha => @x})  if @@first_flag >= 156
    Window.draw_font_ex(20,190,"その時私は、この施設にあるルールがあった事を思い出した。",@message_main,hash = {:alpha => @x}) if @@first_flag >= 234
    Window.draw_font_ex(20,230,"『部屋を綺麗に整えなければ、部屋から出る事はできない』",@message_main,hash = {:color => [255,0,0],:alpha => @x}) if @@first_flag >= 302
    Window.draw_font_ex(20,270,"私は首を傾げた。",@message_main,hash = {:alpha => @x}) if @@first_flag >= 380
    Window.draw_font_ex(20,310,"この部屋は一見して、丁寧に整っているように見えるが……",@message_main,hash = {:alpha => @x}) if @@first_flag >= 458
    if @@first_flag > 700
       @x -= 2
    end
  elsif @@light < 256
    Window.drawAlpha(0,0,@image,@@light)
    @@light += 1
  else
    Window.draw(0,0,@image)
    if Input.mousePush?(M_LBUTTON)
  @pointer.x = Input.mousePosX
  @pointer.y = Input.mousePosY
# Sprite.check(@pointer,@kari)
      Sprite.check(@pointer,@r_bed)#結合チェック
      Sprite.check(@pointer,@l_bed)#結合チェック
      Sprite.check(@pointer,@do_or)#結合チェック
      if !Sprite.check(@pointer, @migihaji) && 
         !Sprite.check(@pointer, @hidarihaji) && 
         @pointer.y > 460 then
           @@flag_deskandchair = 0
      end
      if !Sprite.check(@pointer, @migihaji) && 
         !Sprite.check(@pointer, @hidarihaji) &&
         @pointer.x >= 158 && @pointer.x <= 352 &&
         @pointer.y >= 83 && @pointer.y <= 109 then
         @@flag_air = 0
      end
      if !Sprite.check(@pointer, @migihaji) && 
         !Sprite.check(@pointer, @hidarihaji) &&
         @pointer.x >= 106 && @pointer.x <= 130 &&
         @pointer.y >= 235 && @pointer.y <= 270 then
            @@flag_tel = 0
      end
    end 

    if $global_click_flag_s == 1
      @pointer.x = Input.mousePosX
      @pointer.y = Input.mousePosY
      if Sprite.check(@pointer,@gomi1)
        @gomi1.visible = false
        $gomi1 = true
        if @s_flag1 == 0
          @s_flag1 = 1
          @souji.play
        end
      end

      if Sprite.check(@pointer,@gomi2)
        @gomi2.visible = false
        $gomi2 = true
        if @s_flag2 == 0
          @s_flag2 = 1
          @souji.play
        end
      end

      if Sprite.check(@pointer,@gomi3)
        @gomi3.visible = false
        $gomi3 = true
        if @s_flag3 == 0
          @s_flag3 = 1
          @souji.play
        end
      end
    end




    Sprite.draw(@gomi1) unless $gomi1
    Sprite.draw(@gomi2) unless $gomi2
    Sprite.draw(@gomi3) unless $gomi3

    if Sprite.check(@pointer,@migihaji)
    @migihaji.draw
      end
    if Sprite.check(@pointer,@hidarihaji)
      @hidarihaji.draw
    end
    if @kaisi_f == 0
     @kaisi_f = 1
     $kaisi.play
    end
    
  end
         if @@flag_deskandchair < 60
         Util.message("机と椅子がある。\nテーブルの上には何もないようだ。")
         @@flag_deskandchair += 1
         end
         if @@flag_air < 60
         Util.message("エアコンだ。")
         @@flag_air += 1
         end
         if @@flag_tel < 60
         Util.message("電話がある。")
         @@flag_tel += 1
         end
	
end
end