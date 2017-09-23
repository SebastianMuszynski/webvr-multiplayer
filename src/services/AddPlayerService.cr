class AddPlayerService
  def self.call(player : Player, game : Game)
    player.set_color(game.get_new_player_color)
    player.set_position(game.get_new_player_position)
    game.add_player(player)

    SocketsHelper.unicast(player, Action.new_player(player.id))
    SocketsHelper.broadcast(game.players, Action.players(game.players))
    SocketsHelper.broadcast(game.players, Action.enemies(game.enemies))
    
    if game.can_start_game
      SocketsHelper.broadcast(game.players, Action.start_game)
    else 
      if game.is_waiting_for_players
        SocketsHelper.broadcast(game.players, Action.wait_for_players)
      end
    end
  end
end
