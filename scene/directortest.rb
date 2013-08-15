# coding: UTF-8

require_relative 'scene/title'
require_relative 'scene/zentai'
require_relative 'scene/rbed'
require_relative 'scene/lbed'
require_relative 'scene/kinko'
require_relative 'scene/senmen'
require_relative 'scene/door'
# require_relative 'scene/ending'

require_relative 'lib/util'
require_relative 'lib/shoutotu'
require_relative 'lib/mbox'

# ゲーム進行管理用クラス
class Director
  # 初期化処理
  def initialize
    y = 0
    @item_box = []
    # ゲームを構成する各シーンの管理オブジェクトを生成
    @@scenes = {}
#	作ったクラスのインスタンスを作成。
        $shoes_get_flag = 0
	@@scenes[:title]  = Title.new
	@@scenes[:zentai] = Zentai.new
	@@scenes[:rbed] = Rbed.new
	@@scenes[:lbed] = Lbed.new
	@@scenes[:door] = Door.new
	@@scenes[:kinko] = Kinko.new
	@@scenes[:senmen] = Senmen.new
# 	@@scenes[:ending] = Ending.new
        @@shoes = Image.load("images/shoes.png")
#  @pointer = Sprite.new(0,0)
#  @pointer = collision = [0, 0, 1]
#  @click_flag = 0
  @item_box_img = Util.load_image("../images/box.png")
  while y < 400
    @item_box << Sprite.new(480,y,@item_box_img)
    y += 60
  end
  @@current_scene = :title
  end

  # シーン進行メソッド
  def play
    # 現在設定されているシーン管理オブジェクトのplayメソッドへ
    # 処理を委譲する
    @@scenes[@@current_scene].play
    @item_box.each do |value|
      value.draw
    end
    Window.draw(490,13,@@shoes) if $shoes_get_flag == 1
  end

  # シーン切り替え用メソッド
  # ===引数
  # scene: 切り替え先シーンの名称
  #        シンボルで指定する（例： Director.change_scene(:ending)）
  def self.change_scene(scene)
    @@current_scene = scene
  end
end
