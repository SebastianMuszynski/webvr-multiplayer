class RemovePlayerService
  def self.call(player : Player, game : Game)
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