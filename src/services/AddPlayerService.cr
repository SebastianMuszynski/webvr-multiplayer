class AddPlayerService
  def self.call(player : Player, game : Game)
    player.color = game.scene.get_new_player_color
    player.player_settings.position = game.scene.get_new_player_position
    game.add_player_with_enemies(player)
    
    players = game.scene.players
    enemies = game.scene.enemies

    SocketsHelper.unicast(player, Action.new_player(player.id))
    SocketsHelper.broadcast(players, Action.players(players))
    SocketsHelper.broadcast(players, Action.enemies(enemies))
    
    
    SocketsHelper.broadcast(players, Action.start_game)
    
    # if game.can_start
    #   SocketsHelper.broadcast(players, Action.start_game)
    # else 
    #   if game.is_waiting_for_players
    #     SocketsHelper.broadcast(players, Action.wait_for_players)
    #   end
    # end
  end
end
