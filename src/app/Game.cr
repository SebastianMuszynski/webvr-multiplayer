class Game
  def initialize
    @scene = Scene.new
  end
  
  def add_player(player : Player)
    @scene.add_player(player)
    @scene.add_enemies_for_player(INITIAL_ENEMIES_NUMBER, player)
  end
  
  def players
    @scene.players
  end
  
  # Send a message to a single player
  def unicast(player : Player, action : Action)
    player.socket.send action.to_json
  end
  
  # Send a message to all the players
  def broadcast(players : Array(Player), action : Action)
    players.each { |player| unicast(action, player) }
  end
end