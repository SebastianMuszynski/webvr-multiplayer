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


# Sockets

SOCKETS = [] of HTTP::WebSocket
PLAYERS = [] of Player

ws "/room" do |socket|
  SOCKETS << socket

  socket.on_message do |message|
    # Add player
    PLAYERS << Player.from_json(message)

    # Display info about the players
    p PLAYERS

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
