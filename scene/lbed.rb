# coding: UTF-8

# 左のベッドを確認するシーンの管理用クラス

require 'dxruby'

class Lbed
  def initialize
    # @ はインスタンス変数　またインスタンスを呼ぶ時も値が残っている
    # 必要な画像はすべて最初に読み込み、クリックでフラグとともに変更できるようにする予定
    @lbed1 = Image.load("images/lbed1.png")
    @lbed2 = Image.load("images/lbed2.png")
    @lbed3 = Image.load("images/lbed3.png")
    @lbed4 = Image.load("images/lbed4.png")
    @lbed5 = Image.load("images/lbed5.png")
    @lbed6 = Image.load("images/lbed6.png")
    # 効果音の読み込み(未実装)
#    @lbedsound = Sound.new("")
    # 当たり判定用の画像の読み込み
    @hantei = Image.load("images/kakebuton.png")
    @hantei.setColorKey([0, 0, 0])
    # 衝突判定の設定
    @pointer = Sprite.new(0,0)
    @pointer.collision = [0,0,1]
    @kakebuton = Sprite.new(140,250,@hantei)
    @hidarihaji = Shoutotu.new("zentai") #全体へ戻るリンクへの当たり判定
#     @hidarihaji.collision = [0,0,50,640]
    @hidarihaji.collision = [0,0,40,640]
    @haji = Sprite.new(0,0) #全体に戻る左端のリンク
#     @haji.collision = [0,0,50,640]
    @haji.image = Image.load("images/arrow_left.png")
    @haji.image.setColorKey([255,255,255]) #画像の背景を透明にする
    @haji.x = 0 #矢印画像の位置
    @haji.y = 0 #矢印画像の位置
    # 布団の状態を表すフラグ
    @lbedflg = 1
    @hutontataku = Sound.new("sounds/hutontataku.wav")
    @hutontataku.setVolume(255)
    @@flag = 90
  end

  def play
      @pointer.x = Input.mousePosX
      @pointer.y = Input.mousePosY
    # 通常プレイ時
    # マウスクリック時、マウスポインターの位置情報を更新
    if Input.mousePush?(M_LBUTTON)
#      @pointer.x = Input.mousePosX
#      @pointer.y = Input.mousePosY
    # 布団をクリックしたらlbedフラグを増やす
      if Sprite.check(@pointer,@kakebuton)
        if @lbedflg < 6
          @lbedflg += 1
          if @lbedflg == 5
            $huton_l = true
          else
            $huton_l = false
          end
         # 布団を動かす音を鳴らす（未実装）
          @hutontataku.play
        else
          @lbedflg = 1
          $huton_l = false
          @hutontataku.play
        end
      elsif !Sprite.check(@pointer, @kakebuton) && !Sprite.check(@pointer, @hidarihaji)
       @@flag = 0  
      end
      Sprite.check(@pointer,@hidarihaji)
    end


    # ウィンドウを描画
    # lbedフラグを読み、どの画像を表示するか決めるようにする
    # 現状では、画像の上にさらに画像を表示しているだけ
    case @lbedflg
      when 1 then
        Window.draw(0,0,@lbed1)
      when 2 then
        Window.draw(0,0,@lbed2)
      when 3 then
        Window.draw(0,0,@lbed3)
      when 4 then
        Window.draw(0,0,@lbed4)
      when 5 then
        Window.draw(0,0,@lbed5)
      when 6 then
        Window.draw(0,0,@lbed6)
    end
    if Sprite.check(@pointer,@haji)
    @haji.draw
    end

    if @@flag < 60
      Util.message("布団が積まれている。")
      @@flag += 1
    end
  end
end
