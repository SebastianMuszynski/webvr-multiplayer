class UpdatePlayerRotation
  def self.call(action : Action, player : Player, game : Game)
    rotation = ActionHelper.new(action).get_player_rotation
    player.rotation = rotation

    players = game.scene.players

    SocketsHelper.broadcast_to_others(
      players: players,
      excluded_player: player,
      action: Action.players(players)
    )
  end
end
