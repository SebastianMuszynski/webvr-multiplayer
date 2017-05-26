SOCKETS = [] of HTTP::WebSocket

# Init the scene
SCENE = Scene.new
SCENE.generate_enemies(10)

ws "/room" do |socket|
  SOCKETS << socket

  socket.on_message do |message|
    # Decode action
    action = Action.from_json(message)

    case action.type_
    when "NEW_PLAYER_REQUEST"
      player = Player.random
      SCENE.add_player(player)

      # Set current player id
      newPlayerAction = Action.new_player(player.id)
      socket.send newPlayerAction.to_json

      SOCKETS.each do |socket|
        # Broadcast players
        playersAction = Action.players(SCENE.players)
        socket.send playersAction.to_json

        # Broadcast enemies
        enemiesAction = Action.enemies(SCENE.enemies)
        socket.send enemiesAction.to_json
      end
    when "PLAYER_POSITION_CHANGED"
      playerSettings = PlayerSettings.from_json(action.payload.data)

      player_id = action.payload.player_id
      player = SCENE.get_player_by_id(player_id)

      if player
        player.set_player_settings(playerSettings)
        playersAction = Action.players(SCENE.players)

        SOCKETS.each do |otherSocket|
          if otherSocket != socket
            otherSocket.send playersAction.to_json
          end
        end
      end

    when "REMOVE_ENEMY_REQUEST"
      enemy_id = action.payload.data
      player_id = action.payload.player_id

      player = SCENE.get_player_by_id(player_id)

      if player
        player.add_points(1) if player
        # playerAction = Action.player(player)
        # socket.send playerAction.to_json

        playersAction = Action.players(SCENE.players)
        SOCKETS.each do |socket|
          socket.send playersAction.to_json
        end
      end

      SCENE.remove_enemy_by_id(enemy_id)
      enemiesAction = Action.enemies(SCENE.enemies)

      SOCKETS.each do |socket|
        socket.send enemiesAction.to_json
      end
    else
      p "Unrecognised action type: #{action.type_}"
    end
  end

  socket.on_close do
    SOCKETS.delete socket
  end
end
