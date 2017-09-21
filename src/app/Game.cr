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
end