class Action
  def initialize(@type_ : String, @payload : ActionPayload)
  end

  def self.new_player(player_id : String)
    new("NEW_PLAYER_RESPONSE", ActionPayload.new(player_id, ""))
  end

  def self.players(players : Array(Player))
    new("PLAYERS", ActionPayload.new(players.to_json, ""))
  end

  def self.enemies(enemies : Array(Enemy))
    new("ENEMIES", ActionPayload.new(enemies.to_json, ""))
  end

  def self.player(player : Player)
    new("PLAYER", ActionPayload.new(player.to_json, player.id))
  end

  JSON.mapping(
    type_: String,
    payload: { type: ActionPayload, nilable: false },
  )
end

class ActionPayload
  def initialize(@data : String, @player_id : String)
  end

  JSON.mapping(
    data: String,
    player_id: String
  )
end
