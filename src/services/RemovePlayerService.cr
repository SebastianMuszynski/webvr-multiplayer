class RemovePlayerService
  def self.call(player : Player, game : Game)
    game.remove_player(player)

    SocketsHelper.broadcast(game.players, Action.players(game.players))
    SocketsHelper.broadcast(game.players, Action.enemies(game.enemies))
  end
end
