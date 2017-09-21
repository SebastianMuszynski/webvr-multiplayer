class RemovePlayerService
  def self.call(player : Player, game : Game)
    game.remove_player(player)

    SocketsHelper.broadcast_to_others(
      players: game.players,
      excluded_player: player,
      action: Action.players(game.players)
    )
  end
end
