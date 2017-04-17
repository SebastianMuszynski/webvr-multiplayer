require "kemal"

class Position
  JSON.mapping(
    x: Float32,
    y: Float32,
    z: Float32,
  )
end

class Player
  JSON.mapping(
    id: String,
    position: { type: Position, nilable: false },
  )
end

class Enemy
  JSON.mapping(
    id: String,
    position: { type: Position, nilable: false },
  )
end

class Scene
  JSON.mapping(
    players: Array(Player),
    enemies: Array(Enemy),
  )
end

class Action
  JSON.mapping(
    type_: String,
    payload: String
  )
end

SOCKETS = [] of HTTP::WebSocket
PLAYERS = [] of Player
ENEMIES = [] of Enemy

ws "/room" do |socket|
  SOCKETS << socket

  socket.on_message do |message|
    # Decode action
    action = Action.from_json(message)

    case action.type_
    when "NEW_PLAYER"
      PLAYERS << Player.from_json(action.payload)
    else
      p "Unrecognised action type: #{action.type_}"
    end

    # Broadcast players
    SOCKETS.each do |socket|
      socket.send PLAYERS.to_json
    end
  end

  socket.on_close do
    SOCKETS.delete socket
  end
end

# Routes

get "/" do
  render "public/index.ecr"
end

Kemal.run
