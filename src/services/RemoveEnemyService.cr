class RemoveEnemyService
  def self.call(action : Action, player : Player, game : Game)
    # Remove the enemy & add a new one
    enemy_id = ActionHelper.new(action).get_enemy_id
    game.remove_enemy_by_id(enemy_id)
    game.add_enemy_for_player(player)

    # Increase player's score
    player.add_point

    SocketsHelper.broadcast(game.players, Action.enemies(game.enemies))
    SocketsHelper.broadcast(game.players, Action.game_over) if game.is_over
  end
end
