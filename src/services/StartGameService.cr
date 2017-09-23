class StartGameService
  def self.call(action : Action, player : Player, game : Game)
    playersNumber = ActionHelper.new(action).get_players_number
    game.set_players_number(playersNumber)
    player.start_game

    if game.can_start_game
      SocketsHelper.broadcast(game.players, Action.start_game)
    else
      SocketsHelper.broadcast(game.players, Action.wait_for_players)
    end
  end
end
