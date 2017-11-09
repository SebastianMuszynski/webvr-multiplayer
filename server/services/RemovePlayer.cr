class RemovePlayer
  def self.call(player : Player, game : Game)
    game.remove_player_with_enemies(player)

    SocketsHelper.broadcast(game.players, Action.players(game.players))
    SocketsHelper.broadcast(game.players, Action.enemies(game.enemies))
  end
end
