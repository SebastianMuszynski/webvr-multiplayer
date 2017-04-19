class Scene
  def initialize()
    @players = [] of Player
    @enemies = [] of Enemy
  end

  def players
    @players
  end

  def add_player(player)
    @players << player
  end

  def enemies
    @enemies
  end

  JSON.mapping(
    players: Array(Player),
    enemies: Array(Enemy),
  )
end
