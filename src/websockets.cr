sockets = [] of HTTP::WebSocket

# Init the scene
scene = Scene.new

ws "/room" do |socket|
  sockets << socket

  socket.on_message do |message|
    # Decode action
    action = Action.from_json(message)

    case action.type_
    when "START_GAME_REQUEST"
      StartGameService.call(action, scene, socket, sockets)
    when "NEW_PLAYER_REQUEST"
      NewPlayerService.call(action, scene, socket, sockets)
    when "PLAYER_POSITION_CHANGED"
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
    when "REMOVE_ENEMY_REQUEST"
      enemy_id = action.payload.data
      player_id = action.payload.player_id

      player = scene.get_player_by_id(player_id)

      if player
        player.add_points(1) if player
        # playerAction = Action.player(player)
        # socket.send playerAction.to_json

        playersAction = Action.players(scene.players)

        scene.generate_enemies_for_player(1, player)
        enemiesAction = Action.enemies(scene.enemies)

        sockets.each do |a_socket|
          a_socket.send playersAction.to_json
          a_socket.send enemiesAction.to_json
        end
      end

      scene.remove_enemy_by_id(enemy_id)
      enemiesAction = Action.enemies(scene.enemies)

      sockets.each do |a_socket|
        a_socket.send enemiesAction.to_json
      end

      if scene.is_game_over
        sockets.each do |a_socket|
          a_socket.send Action.game_over.to_json
        end
      end
    else
      p "Unrecognised action type: #{action.type_}"
    end
  end

  socket.on_close do
    scene.remove_player_by_socket(socket)

    playersAction = Action.players(scene.players)
    sockets.each do |other_socket|
      if other_socket != socket
        other_socket.send playersAction.to_json
      end
    end

    sockets.delete socket
  end
end
