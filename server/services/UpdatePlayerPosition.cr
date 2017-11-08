class UpdatePlayerPosition
  def self.call(action : Action, player : Player, game : Game)
    position = ActionHelper.new(action).get_player_position
    player.position = position

    players = game.scene.players

    SocketsHelper.broadcast_to_others(
      players: players,
      excluded_player: player,
      action: Action.players(players)
    )
  end
end
