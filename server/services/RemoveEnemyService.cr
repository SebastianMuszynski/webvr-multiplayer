class RemoveEnemyService
  def self.call(action : Action, player : Player, game : Game)
    enemy_id = ActionHelper.new(action).get_enemy_id
    game.scene.remove_enemy_by_id(enemy_id)
    game.scene.add_player_enemies(player, 1)
    player.add_point

    players = game.scene.players
    enemies = game.scene.enemies

    SocketsHelper.broadcast(players, Action.players(players))
    SocketsHelper.broadcast(players, Action.enemies(enemies))
    SocketsHelper.broadcast(players, Action.game_over) if game.is_over
  end
end
