require "kemal"

# Sockets

SOCKETS = [] of HTTP::WebSocket

ws "/room" do |socket|
  SOCKETS << socket

  socket.on_message do |message|
    SOCKETS.each { |socket| socket.send message}
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
