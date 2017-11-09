class AddPlayer
  def self.call(player : Player, game : Game)
    game.add_player_with_enemies(player, SETTINGS[:ENEMIES_NUMBER])

    SocketsHelper.unicast(player, Action.new_player(player.id))
    SocketsHelper.broadcast(game.players, Action.players(game.players))
    SocketsHelper.broadcast(game.players, Action.enemies(game.enemies))

    if game.can_start
      SocketsHelper.broadcast(game.players, Action.start_game)
    else
      if game.is_waiting_for_players
        SocketsHelper.broadcast(game.players, Action.wait_for_players)
      end
    end
  end
end
