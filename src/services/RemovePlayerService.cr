class RemovePlayerService
  def self.call(player : Player, game : Game)
    game.remove_player(player)

    SocketsHelper.broadcast_to_others(
      game.players,
      Action.players(game.players),
      excluded_player: player
    )
  end
end
