class Scene
  def initialize
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

  def generate_enemies(enemies_number)
    while enemies_number > 0
      @enemies << Enemy.random
      enemies_number -= 1
    end
  end

  JSON.mapping(
    players: Array(Player),
    enemies: Array(Enemy),
  )
end
