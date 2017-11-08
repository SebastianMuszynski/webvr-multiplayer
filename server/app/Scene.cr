class Scene
  getter players = [] of Player
  getter enemies = [] of Enemy

  def initialize
  end

  private def player_positions
    dist = PLAYER[:DISTANCE_FROM_CENTER]
    center = SETTINGS[:SCENE_CENTER]
    [
      Position.new(center, center, dist),
      Position.new(center, center, -dist),
      Position.new(-dist, center, center),
      Position.new(dist, center, center),
    ]
  end

  # Manage players
  def get_new_player_color
    colors = PLAYER[:COLORS]
    colors[@players.size % colors.size]
  end

  def get_new_player_position
    player_positions[@players.size % player_positions.size]
  end

  def add_player_with_enemies(player : Player, enemies_number : Int32)
    add_player_enemies(player, enemies_number)
    @players << player
  end

  def remove_player_with_enemies(player : Player)
    remove_player_enemies(player)
    @players.delete(player)
  end

  # Manage player's enemies
  def add_player_enemies(player : Player, enemies_number : Int32)
    while enemies_number > 0
      enemy = Enemy.random
      enemy.color = player.color
      @enemies << enemy
      enemies_number -= 1
    end
  end

  private def remove_player_enemies(player : Player)
    @enemies.reject! { |enemy| enemy.color == player.color }
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
