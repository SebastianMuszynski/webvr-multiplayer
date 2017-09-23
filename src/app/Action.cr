class Action
  def initialize(@type_ : String, @payload : ActionPayload)
  end

  def self.new_player(player_id : String)
    new(ACTION_TYPE[:NEW_PLAYER], ActionPayload.new(player_id, ""))
  end

  def self.players(players : Array(Player))
    new(ACTION_TYPE[:PLAYERS], ActionPayload.new(players.to_json, ""))
  end

  def self.enemies(enemies : Array(Enemy))
    new(ACTION_TYPE[:ENEMIES], ActionPayload.new(enemies.to_json, ""))
  end

  def self.player(player : Player)
    new(ACTION_TYPE[:PLAYER], ActionPayload.new(player.to_json, player.id))
  end

  def self.wait_for_players
    new(ACTION_TYPE[:WAIT_FOR_PLAYERS], ActionPayload.new("", ""))
  end

  def self.start_game
    new(ACTION_TYPE[:START_GAME], ActionPayload.new("", ""))
  end

  def self.game_over
    new(ACTION_TYPE[:GAME_OVER], ActionPayload.new("", ""))
  end

  JSON.mapping(
    type_: String,
    payload: ActionPayload
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