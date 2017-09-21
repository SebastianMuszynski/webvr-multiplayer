class SocketsHelper
  # Send a message to a single socket
  def self.unicast(socket : HTTP::WebSocket, action : Action)
    socket.send action.to_json
  end
  
  # Send a message to all the sockets
  def self.broadcast(sockets : Array(HTTP::WebSocket), action : Action)
    sockets.each { |socket| self.unicast(socket, action) }
  end
  
  # Send a message to a single player
  def self.unicast_player(player : Player, action : Action)
    self.unicast(player.socket, action)
  end
  
  # Send a message to all the players
  def self.broadcast_players(players : Array(Player), action : Action)
    players.each { |player| self.unicast(player.socket, action) }
  end
end