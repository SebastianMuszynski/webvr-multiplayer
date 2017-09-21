class SocketsHelper
  # Send a message to a single socket
  def self.unicast_socket(socket : HTTP::WebSocket, action : Action)
    socket.send action.to_json
  end
  
  # Send a message to all the sockets
  def self.broadcast_sockets(sockets : Array(HTTP::WebSocket), action : Action)
    sockets.each { |socket| self.unicast_socket(socket, action) }
  end
  
  # Send a message to a single player
  def self.unicast(player : Player, action : Action)
    self.unicast_socket(player.socket, action)
  end
  
  # Send a message to all the players
  def self.broadcast(players : Array(Player), action : Action)
    players.each { |player| self.unicast(player, action) }
  end
  
  # Send a message to all the players excluding the provided one
  def self.broadcast_to_others(players : Array(Player), 
                               excluded_player: excluded_player : Player, 
                               action : Action)
    players.each do |player| 
      self.unicast(player, action) if player != excluded_player
    end
  end
end