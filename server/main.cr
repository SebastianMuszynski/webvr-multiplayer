require "kemal"

# Sockets

SOCKETS = [] of HTTP::WebSocket
PLAYERS = [] of JSON::Any

ws "/room" do |socket|
  SOCKETS << socket

  socket.on_message do |message|
    # Add player
    PLAYERS << JSON.parse(message)

    # Display info about the players
    p PLAYERS

    # Broadcast players
    SOCKETS.each { |socket| socket.send message }
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
