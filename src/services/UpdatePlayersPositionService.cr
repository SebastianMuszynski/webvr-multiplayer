class UpdatePlayersPositionService
  def self.call(action : Action, player : Player, game : Game)
    settings = ActionHelper.new(action).get_player_settings
    player.set_settings(settings)

    SocketsHelper.broadcast_to_others(
      game.players,
      Action.players(game.players),
      excluded_player: player
    )
  end
end
