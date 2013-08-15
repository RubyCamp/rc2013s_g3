# coding: UTF-8

# タイトル（オープニング）シーンの管理用クラス
class Title
  def initialize
    @@i = 0
    @image =  Image.load("images/title.png")
    @press_image = Sprite.new(59, 541, Util.load_image("title_moji.png"))
    @@light = 0 # 高いほど画面が明るい
    @@first_flag = 0 #明るくなり始めるまでの長さ、初回フラグを兼ねる
    @voice = Sound.new("sounds/titlevoice.wav")
    @voice.setVolume(0)
  end

  def play
    if @@first_flag < 0
       @@first_flag += 1
    elsif @@light < 256
          if @@light <= 255 && @@light >= 250
             @voice.play
           end
          Window.drawAlpha(0,0,@image,@@light)
          @@light += 1
    else
      @@i += 1
      i = 0 if @@i > 80
  	#SPACEが押されたらzentaiシーンへ。
      if Input.keyPush?(K_SPACE)
        Director.change_scene(:zentai)
      end
      Window.draw(0, 0, @image)
      if @@i % 40 >= 0 && @@i % 40 < 20
        Sprite.draw(@press_image) 
      end
    end
  end
end
