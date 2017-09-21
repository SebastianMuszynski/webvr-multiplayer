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
      when MSG_NEW_PLAYER
        AddPlayerService.call(player, game)
      when MSG_START_GAME
        StartGameService.call(action, player, game)
      when MSG_PLAYER_POSITION_CHANGED
        UpdatePlayersPositionService.call(action, player, game)
      when MSG_REMOVE_ENEMY
        RemoveEnemyService.call(action, player, game)
      else
        raise "Unrecognised action type: #{action.type_}"
      end
    rescue ex
      p "Exception: #{ex.message}"
    end
  end

  socket.on_close do
    RemovePlayerService.call(player, game)
  end
end
