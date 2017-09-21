class AddPlayerService
  def self.call(player : Player, game : Game)
    game.add_player(player)
    
    unicast(player, Action.new_player(player.id))
    broadcast(game.players, Action.players(scene.players))
    broadcast(game.players, Action.enemies(scene.enemies))
  end
end