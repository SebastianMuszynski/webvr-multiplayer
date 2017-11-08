class Action
  def initialize(@type_, @payload)
  end

  def self.new_player(player_id : String)
    new(ACTION_TYPE[:NEW_PLAYER], ActionPayload.new(player_id: player_id))
  end

  def self.player(player : Player)
    new(ACTION_TYPE[:PLAYER], ActionPayload.with_id(player, player.id))
  end

  def self.players(players : Array(Player))
    new(ACTION_TYPE[:PLAYERS], ActionPayload.new(players))
  end

  def self.enemies(enemies : Array(Enemy))
    new(ACTION_TYPE[:ENEMIES], ActionPayload.new(enemies))
  end

  def self.start_game
    without_payload(ACTION_TYPE[:START_GAME])
  end

  def self.wait_for_players
    without_payload(ACTION_TYPE[:WAIT_FOR_PLAYERS])
  end

  def self.game_over
    without_payload(ACTION_TYPE[:GAME_OVER])
  end

  private def self.without_payload(action_type)
    new(action_type, ActionPayload.new)
  end

  JSON.mapping(
    type_: String,
    payload: ActionPayload
  )
end

class ActionPayload
  def initialize(data = "", @player_id = "")
    @data = data.to_json
  end

  def self.with_id(payload, id)
    new(payload, id)
  end

  JSON.mapping(
    data: String,
    player_id: String
  )
end
