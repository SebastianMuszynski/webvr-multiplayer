class StartGameService
  def self.call(action : Action, player : Player, game : Game)
    playersNumber = ActionHelper.new(action).get_players_number
    game.set_players_number(playersNumber)
    player.start_game

    players = game.scene.players

    if game.can_start
      SocketsHelper.broadcast(players, Action.start_game)
    else
      SocketsHelper.broadcast(players, Action.wait_for_players)
    end
  end
end
