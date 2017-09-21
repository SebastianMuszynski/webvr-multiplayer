class AddPlayerService
  def self.call(player : Player, game : Game)
    game.add_player(player)
    
    SocketsHelper.unicast_player(player, Action.new_player(player.id))
    SocketsHelper.broadcast_players(game.players, Action.players(game.players))
    SocketsHelper.broadcast_players(game.players, Action.enemies(game.enemies))
  end
end