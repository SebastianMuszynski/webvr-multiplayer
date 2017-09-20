SOCKETS = [] of HTTP::WebSocket

# Init the scene
SCENE = Scene.new

ws "/room" do |socket|
  SOCKETS << socket

  begin
    socket.on_message do |message|
      # Decode action
      action = Action.from_json(message)

      case action.type_
      when "START_GAME_REQUEST"
        player_id = action.payload.player_id
        SCENE.set_player_as_ready_to_play(player_id)

        if SCENE.can_start_game
          p "TRYING TO START GAME FOR ALL"

          SOCKETS.each do |socket|
            socket.send Action.start_game.to_json
          end
        else
          socket.send Action.wait_for_players.to_json
          p Action.wait_for_players.to_json
        end
      when "NEW_PLAYER_REQUEST"
        # player = Player.random
        new_pos = SCENE.get_new_player_position
        player = Player.new(new_pos.x, new_pos.y, new_pos.z, SCENE.get_new_player_color)

        player.assign_socket(socket)
        SCENE.add_player(player)

        SCENE.generate_enemies_for_player(1, player)

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

          SCENE.generate_enemies_for_player(1, player)
          enemiesAction = Action.enemies(SCENE.enemies)

          SOCKETS.each do |socket|
            socket.send playersAction.to_json
            socket.send enemiesAction.to_json
          end
        end

        SCENE.remove_enemy_by_id(enemy_id)
        enemiesAction = Action.enemies(SCENE.enemies)

        SOCKETS.each do |socket|
          socket.send enemiesAction.to_json
        end

        if SCENE.is_game_over
          SOCKETS.each do |socket|
            socket.send Action.game_over.to_json
          end
        end
      else
        p "Unrecognised action type: #{action.type_}"
      end
    end
  rescue
    puts "Error: socket.on_message"
  end

  begin
    socket.on_close do
      SCENE.remove_player_by_socket(socket)

      playersAction = Action.players(SCENE.players)
      SOCKETS.each do |otherSocket|
        if otherSocket != socket
          otherSocket.send playersAction.to_json
        end
      end

      SOCKETS.delete socket
    end
  rescue
    puts "Error: socket.on_close"
  end
end
