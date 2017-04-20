class Action
  def initialize(@type_ : String, @payload : String)
  end

  def self.new_player(player : Player)
    new("NEW_PLAYER_RESPONSE", player.to_json)
  end

  def self.players(players : Array(Player))
    new("PLAYERS", players.to_json)
  end

  def self.enemies(enemies : Array(Enemy))
    new("ENEMIES", enemies.to_json)
  end

  JSON.mapping(
    type_: String,
    payload: String
  )
end
