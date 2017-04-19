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
    when "NEW_PLAYER"
      player = Player.from_json(action.payload)
      SCENE.add_player(player)
    when "REMOVE_ENEMY"
      enemy_id = action.payload
      SCENE.remove_enemy_by_id(enemy_id)
    else
      p "Unrecognised action type: #{action.type_}"
    end

    enemiesAction = Action.enemies(SCENE.enemies)
    SOCKETS.each do |socket|
      socket.send enemiesAction.to_json
    end
  end

  socket.on_close do
    SOCKETS.delete socket
  end
end
