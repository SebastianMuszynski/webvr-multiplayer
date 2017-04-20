class Action
  def initialize(@type_ : String, @payload : String)
  end

  def self.players(players : Array(Enemy))
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
