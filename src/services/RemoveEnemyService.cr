class RemoveEnemyService
  def self.call(action : Action, player : Player, game : Game)
    enemy_id = ActionHelper.new(action).get_enemy_id
    game.scene.remove_enemy_by_id(enemy_id)
    game.add_enemy_for_player(player)

    player.add_point
    
    SocketsHelper.broadcast(game.players, Action.players(game.players))
    SocketsHelper.broadcast(game.players, Action.enemies(game.enemies))
    SocketsHelper.broadcast(game.players, Action.game_over) if game.is_over
  end
end
