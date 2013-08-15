class Shoutotu < Sprite
	def initialize(obj_type)
		super(0,0)

		@obj_type = obj_type
	end

	def hit(obj)
		Director.change_scene(:zentai) if @obj_type == "zentai"
		Director.change_scene(:rbed) if @obj_type == "rbed"
		Director.change_scene(:lbed) if @obj_type == "lbed"
		Director.change_scene(:door) if @obj_type == "door"
		Director.change_scene(:kinko) if @obj_type == "kinko"
		Director.change_scene(:senmen) if @obj_type == "senmen"
		Director.change_scene(:ending) if @obj_type == "ending"
		Director.change_scene(:title) if @obj_type == "title"
	end
end