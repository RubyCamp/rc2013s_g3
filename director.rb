# coding: UTF-8
require_relative 'scene/title'
require_relative 'scene/zentai'
require_relative 'scene/rbed'
require_relative 'scene/lbed'
require_relative 'scene/kinko'
require_relative 'scene/senmen'
require_relative 'scene/door'
require_relative 'scene/ending'
require_relative 'lib/util'
require_relative 'lib/shoutotu'
require_relative 'lib/mbox'

# ゲーム進行管理用クラス
class Director
  # 初期化処理
  def initialize
#    y = 0
   # @item_box = []
    # ゲームを構成する各シーンの管理オブジェクトを生成
    @@scenes = {}
#	作ったクラスのインスタンスを作成。
    #    $shoes_get_flag = 0
   $huron_r = false
   $surippa = false
   $huton_l = false
   $door = false
   $suiteki = false
   $air_flag = true
   $gomi1 = false
   $gomi2 = false
   $gomi3 = false
   $souji = false



   $global_click_flag = 0
   $global_click_flag_s = 0
   $shoes_get_flag = 0
   $souji_get_flag = 0
   $item_drag = Item.new
   $m_pointer = Sprite.new(0,0)
   $m_pointer.collision = [0,0,1]
   $item_lost_shoes = false
   $item_lost_souji = false

   $clear_flag = 0

	@@scenes[:title]  = Title.new
	@@scenes[:zentai] = Zentai.new
	@@scenes[:rbed] = Rbed.new
	@@scenes[:lbed] = Lbed.new
	@@scenes[:door] = Door.new
	@@scenes[:kinko] = Kinko.new
	@@scenes[:senmen] = Senmen.new
 	@@scenes[:ending] = Ending.new
#        @@shoes = Image.load("images/shoes.png")
#  @pointer = Sprite.new(0,0)
#  @pointer = collision = [0, 0, 1]
#  @click_flag = 0
#  @item_box_img = Util.load_image("../images/box.png")
#  while y < 400
#    @item_box << Sprite.new(480,y,@item_box_img)
#    y += 60
#  end
  @@current_scene = :title
  end

  # シーン進行メソッド
  def play
    # 現在設定されているシーン管理オブジェクトのplayメソッドへ
    # 処理を委譲する
    @@scenes[@@current_scene].play
#    @item_box.each do |value|
#      value.draw
#    end
#    Window.draw(490,13,@@shoes) if $shoes_get_flag == 1
    $item_drag.play
  end

  # シーン切り替え用メソッド
  # ===引数
  # scene: 切り替え先シーンの名称
  #        シンボルで指定する（例： Director.change_scene(:ending)）
  def self.change_scene(scene)
    @@current_scene = scene
  end
end

class Item
  def initialize
    @item_box = []

    @shoes = Image.load("images/shoes.png")
    $hit_point = Sprite.new(0,0)
    $hit_point.collision = [480,0,540,60]

    @i_souji = Image.load("images/souji.png")
    @i_souji.setColorKey([255,255,255])
    $s_hit_point = Sprite.new(0,0)
    $s_hit_point.collision = [480,61,540,120]

    @item_box_img = Util.load_image("box.png")
    y = 0
    while y < 400
      @item_box << Sprite.new(480,y,@item_box_img)
      y += 60
    end
  end

  def play
    if $clear_flag == 0
      @item_box.each do |value|
        value.draw
      end
    end
    if Input.mousePush?(M_LBUTTON) && $shoes_get_flag == 1 && $item_lost_shoes == false
      # 現時点のマウス座標を取得し、ポインタオブジェクトの座標を更新
      $m_pointer.x = Input.mousePosX
      $m_pointer.y = Input.mousePosY
      if Sprite.check($m_pointer,$hit_point)
        #画像がクリックされたらクリックフラグをオンし、ドラッグで画像がついてくるようにする。また元画像を消す。
        $global_click_flag = 1
      end
    end

    if Input.mousePush?(M_LBUTTON) && $souji_get_flag == 1 && $item_lost_souji == false
      # 現時点のマウス座標を取得し、ポインタオブジェクトの座標を更新
      $m_pointer.x = Input.mousePosX
      $m_pointer.y = Input.mousePosY
      if Sprite.check($m_pointer,$s_hit_point)
        #画像がクリックされたらクリックフラグをオンし、ドラッグで画像がついてくるようにする。また元画像を消す。
        $global_click_flag_s = 1
      end
    end

    if Input.mouseDown?(M_LBUTTON) && $global_click_flag == 1 && $item_lost_shoes == false
      x = Input.mousePosX
      y = Input.mousePosY
      Window.draw(x - 20,y - 20,@shoes)
    else
      $global_click_flag = 0
    end

    if Input.mouseDown?(M_LBUTTON) && $global_click_flag_s == 1 && $item_lost_souji == false
      x = Input.mousePosX
      y = Input.mousePosY
      Window.draw(x - 20,y - 20,@i_souji)
    else
      $global_click_flag_s = 0
    end

    Window.draw(490,63,@i_souji) if $souji_get_flag == 1 && $global_click_flag_s == 0 && $item_lost_souji == false
    Window.draw(490,13,@shoes) if $shoes_get_flag == 1 && $global_click_flag == 0 && $item_lost_shoes == false
  end
end