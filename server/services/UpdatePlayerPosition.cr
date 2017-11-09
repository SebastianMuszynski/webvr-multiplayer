class UpdatePlayerPosition
  def self.call(action : Action, player : Player, game : Game)
    position = ActionHelper.new(action).get_player_position
    player.position = position

    SocketsHelper.broadcast_to_others(
      players: game.players,
      excluded_player: player,
      action: Action.players(game.players)
    )
  end
end
