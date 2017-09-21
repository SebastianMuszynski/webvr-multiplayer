class StartGameService
  def self.call(action : Action, game : Game, socket : HTTP::WebSocket, sockets : Array(HTTP::WebSocket))
    player_id = action.payload.player_id
    scene.set_player_as_ready_to_play(player_id)

    if scene.can_start_game
      p "TRYING TO START GAME FOR ALL"

      sockets.each do |a_socket|
        a_socket.send Action.start_game.to_json
      end
    else
      socket.send Action.wait_for_players.to_json
      p Action.wait_for_players.to_json
    end
  end
end