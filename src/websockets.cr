sockets = [] of HTTP::WebSocket

# Init the scene
scene = Scene.new

ws "/room" do |socket|
  sockets << socket

  socket.on_message do |message|
    # Decode action
    action = Action.from_json(message)

    begin
      case action.type_
      when START_GAME_REQUEST
        StartGameService.call(action, scene, socket, sockets)
      when NEW_PLAYER_REQUEST
        NewPlayerService.call(action, scene, socket, sockets)
      when PLAYER_POSITION_CHANGED
        UpdatePlayersPositionService.call(action, scene, socket, sockets)
      when REMOVE_ENEMY_REQUEST
        RemoveEnemyService.call(action, scene, socket, sockets)
      else
        raise "Unrecognised action type: #{action.type_}"
      end
    rescue ex
      p "Exception: #{ex.message}"
    end
  end

  socket.on_close do
    RemovePlayerService.call(scene, socket, sockets)
  end
end
