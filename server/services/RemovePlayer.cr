class RemovePlayer
  def self.call(player : Player, game : Game)
    game.scene.remove_player_with_enemies(player)
    players = game.scene.players
    enemies = game.scene.enemies
    SocketsHelper.broadcast(players, Action.players(players))
    SocketsHelper.broadcast(players, Action.enemies(enemies))
  end
end
