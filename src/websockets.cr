game = Game.new

ws "/room" do |socket|
  player = Player.new(socket)

  socket.on_message do |message|
    action = ActionHelper.decode(message)
    
    p action

    begin
      case action.type_
      when MSG[:NEW_PLAYER]
        AddPlayerService.call(player, game)
      when MSG[:START_GAME]
        StartGameService.call(player, game)
      when MSG[:UPDATE_POSITION]
        UpdatePlayersPositionService.call(action, player, game)
      when MSG[:REMOVE_ENEMY]
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
