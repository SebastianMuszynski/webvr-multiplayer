SOCKETS = [] of HTTP::WebSocket

# Init the scene
SCENE = Scene.new
SCENE.generate_enemies(5)

ws "/room" do |socket|
  SOCKETS << socket

  socket.on_message do |message|
    # Decode action
    action = Action.from_json(message)

    case action.type_
    when "NEW_PLAYER_REQUEST"
      player = Player.random
      SCENE.add_player(player)

      newPlayerAction = Action.new_player(player)
      socket.send newPlayerAction.to_json
    when "REMOVE_ENEMY_REQUEST"
      enemy_id = action.payload
      SCENE.remove_enemy_by_id(enemy_id)

      enemiesAction = Action.enemies(SCENE.enemies)
      SOCKETS.each do |socket|
        socket.send enemiesAction.to_json
      end
    else
      p "Unrecognised action type: #{action.type_}"
    end

    playersAction = Action.players(SCENE.players)
    SOCKETS.each do |socket|
      socket.send playersAction.to_json
    end
  end

  socket.on_close do
    SOCKETS.delete socket
  end
end
