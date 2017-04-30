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

  def remove_enemy_by_id(enemy_id)
    enemy = @enemies.find { |enemy| enemy.id == enemy_id }
    enemy && enemy.hide
  end

  JSON.mapping(
    players: Array(Player),
    enemies: Array(Enemy),
  )
end
