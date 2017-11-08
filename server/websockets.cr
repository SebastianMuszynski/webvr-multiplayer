game = Game.new

ws "/room" do |socket|
  player = Player.new(socket)

  socket.on_message do |message|
    action = ActionHelper.decode(message)

    begin
      case action.type_
      when MSG[:NEW_PLAYER]
        AddPlayer.call(player, game)
      when MSG[:START_GAME]
        StartGame.call(action, player, game)
      when MSG[:UPDATE_POSITION]
        UpdatePlayerPosition.call(action, player, game)
      when MSG[:UPDATE_ROTATION]
        UpdatePlayerRotation.call(action, player, game)
      when MSG[:REMOVE_ENEMY]
        RemoveEnemy.call(action, player, game)
      else
        raise "Unrecognised action type: #{action.type_}"
      end
    rescue ex
      p "Exception: #{ex.message}"
    end
  end

  socket.on_close do
    RemovePlayer.call(player, game)
  end
end
