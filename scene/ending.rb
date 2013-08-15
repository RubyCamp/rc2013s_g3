# coding: UTF-8

class Ending
  def initialize
    @end_img = Util.load_image("../images/end.png")
    @endin = Sprite.new(0,0, @end_img)
    @fin_saigo = Util.load_image("../images/fin1.png")
    @fin_3 =Util.load_image("../images/fin2.png")
    @fin_2 =Util.load_image("../images/fin3.png")
    @fin_saisho =Util.load_image("../images/fin4.png")
    @fin1 = Sprite.new(@fin_saisho)
    @fin2 = Sprite.new(@fin_2)
    @fin3 = Sprite.new(@fin_3)
    @fin4 = Sprite.new(@fin_saigo)
    @endroll_img = Util.load_image("../images/endroll.png")
      @endroll = Sprite.new(0,640, @endroll_img)
    @@fin_flag = 0
    @@fin_fin = 0 #finをフェードインさせるためのクラス変数
      @@end_flag = 0
    @endsound = Sound.new("sounds/011.mid")
    @endsound_f = 0

  end
  def play
   if @endin.x > -1400 
     @endin.x -= 4
   end
   Sprite.draw(@endin)

   if  400 < @@end_flag 
     @endroll.y -= 3 if @endroll.y > -1000
  else
    @@end_flag +=1
  end
  Sprite.draw(@endroll) 

    if   1000 < @@fin_flag 
      @@fin_fin += 1 if @@fin_fin<255
      Window.drawAlpha(0,0,@fin_saigo,@@fin_fin) 
     else
      @@fin_flag += 1
      end
    if @endsound_f == 0
    @endsound_f = 1
    $kaisi.stop
    @endsound.play
    end


  end
end