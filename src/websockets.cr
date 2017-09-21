# sockets = [] of HTTP::WebSocket

game = Game.new

ws "/room" do |socket|
  player = Player.new(socket)
  # sockets << socket

  socket.on_message do |message|
    # Decode action
    action = Action.from_json(message)

    begin
      case action.type_
      when START_GAME_REQUEST
        StartGameService.call(action, game, socket, sockets)
      when NEW_PLAYER_REQUEST
        AddPlayerService.call(player, game)
      when PLAYER_POSITION_CHANGED
        UpdatePlayersPositionService.call(action, game, socket, sockets)
      when REMOVE_ENEMY_REQUEST
        RemoveEnemyService.call(action, game, socket, sockets)
      else
        raise "Unrecognised action type: #{action.type_}"
      end
    rescue ex
      p "Exception: #{ex.message}"
    end
  end

  socket.on_close do
    RemovePlayerService.call(game, socket, sockets)
  end
end
