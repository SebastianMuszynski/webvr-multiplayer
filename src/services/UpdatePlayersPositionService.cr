class UpdatePlayersPositionService
  def self.call(action : Action, player : Player, game : Game)
    settings = ActionHelper.new(action).get_player_settings
    player.player_settings = settings

    SocketsHelper.broadcast_to_others(
      players: game.players,
      excluded_player: player,
      action: Action.players(game.players)
    )
  end
end
