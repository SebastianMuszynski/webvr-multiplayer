class UpdatePlayerRotation
  def self.call(action : Action, player : Player, game : Game)
    rotation = ActionHelper.new(action).get_player_rotation
    player.rotation = rotation

    SocketsHelper.broadcast_to_others(
      players: game.players,
      excluded_player: player,
      action: Action.players(game.players)
    )
  end
end
