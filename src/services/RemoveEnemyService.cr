class RemoveEnemyService
  def self.call(action : Action, scene : Scene, socket : HTTP::WebSocket, sockets : Array(HTTP::WebSocket))
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
  end
end