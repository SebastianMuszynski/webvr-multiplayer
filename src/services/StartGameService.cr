class StartGameService
  def self.call(player : Player, game : Game)
    # player_id = ActionHelper.new(action).get_player_id
    # player = game.get_player(player_id)
    player.start_game

    if game.can_start_game
      SocketsHelper.broadcast(game.players, Action.start_game)
    else
      SocketsHelper.unicast(player, Action.wait_for_players)
    end
  end
end
