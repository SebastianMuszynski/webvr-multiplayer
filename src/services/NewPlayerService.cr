class NewPlayerService
  def self.call(action : Action, scene : Scene, socket : HTTP::WebSocket, sockets : Array(HTTP::WebSocket))
    # player = Player.random
    new_pos = scene.get_new_player_position
    player = Player.new(new_pos.x, new_pos.y, new_pos.z, scene.get_new_player_color)

    player.assign_socket(socket)
    scene.add_player(player)

    scene.generate_enemies_for_player(1, player)

    # Set current player id
    newPlayerAction = Action.new_player(player.id)
    socket.send newPlayerAction.to_json

    sockets.each do |a_socket|
      # Broadcast players
      playersAction = Action.players(scene.players)
      a_socket.send playersAction.to_json

      # Broadcast enemies
      enemiesAction = Action.enemies(scene.enemies)
      a_socket.send enemiesAction.to_json
    end
  end
end