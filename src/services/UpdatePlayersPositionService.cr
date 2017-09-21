class UpdatePlayersPositionService
  def self.call(action : Action, game : Game, socket : HTTP::WebSocket, sockets : Array(HTTP::WebSocket))
    playerSettings = PlayerSettings.from_json(action.payload.data)

    player_id = action.payload.player_id
    player = scene.get_player_by_id(player_id)

    if player
      player.set_player_settings(playerSettings)
      playersAction = Action.players(scene.players)

      sockets.each do |other_socket|
        if other_socket != socket
          other_socket.send playersAction.to_json
        end
      end
    end
  end
end