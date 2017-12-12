class RemoveEnemy
  def self.call(action : Action, player : Player, game : Game)
    enemy_id = ActionHelper.new(action).get_enemy_id
    game.remove_enemy_by_id(enemy_id)
    game.add_enemies_for_player(player, 1.to_u8)
    player.add_point

    if game.is_over
      SocketsHelper.broadcast(game.players, Action.game_over) 
    else
      SocketsHelper.broadcast(game.players, Action.enemies(game.enemies))
      SocketsHelper.broadcast(game.players, Action.players(game.players))
    end
  end
end
