class ActionHelper
  def initialize(@action : Action)
  end

  def self.decode(message : String)
    Action.from_json(message)
  end

  def get_data
    @action.payload.data
  end

  def get_player_id
    @action.payload.player_id
  end

  def get_enemy_id
    @action.payload.data
  end

  def get_player_settings
    PlayerSettings.from_json(self.get_data)
  end
end
