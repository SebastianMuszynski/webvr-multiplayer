class UpdatePlayersPositionService
  def self.call(action : Action, player : Player, game : Game)
    settings = ActionHelper.new(action).get_player_settings
    player.player_settings = settings
    
    players = game.scene.players

    SocketsHelper.broadcast_to_others(
      players: players,
      excluded_player: player,
      action: Action.players(players)
    )
  end
end
