class Scene
  getter players = [] of Player
  getter enemies = [] of Enemy
  
  def initialize
    init_player_positions()
  end
  
  private def init_player_positions
    dist = PLAYER[:DISTANCE_FROM_CENTER]
    center = SETTINGS[:SCENE_CENTER]
    @player_positions = [
      Position.new(center, center, dist),
      Position.new(center, center, -dist),
      Position.new(-dist, center, center),
      Position.new(dist, center, center),
    ]
  end

  def add_player(player : Player)
    @players << player
  end

  def add_enemies_for_player(enemies_number : Int32, player : Player)
    while enemies_number > 0
      enemy = Enemy.random
      enemy.set_color(player.color)
      @enemies << enemy
      enemies_number -= 1
    end
  end

  def get_new_player_color
    colors = PLAYER[:COLORS]
    colors[@players.size % colors.size]
  end

  def get_new_player_position
    @player_positions[@players.size % @player_positions.size]
  end

  def remove_player(player : Player)
    self.remove_player_enemies(player)
    @players.delete(player)
  end
  
  def remove_player_enemies(player : Player)
    @enemies.reject! { |enemy| enemy.color == player.color }
  end

  def get_player(player_id : String)
    @players.find { |player| player.id == player_id }
  end

  def remove_enemy_by_id(enemy_id)
    enemy = @enemies.find { |enemy| enemy.id == enemy_id }
    enemy && enemy.hide
  end

  def can_start_game
    @players.all? { |player| player.is_ready_to_play }
  end

  def is_game_over
    @players.any? { |player| player.points >= SETTINGS[:POINTS_NUMBER_TO_WIN] }
  end

  JSON.mapping(
    players: Array(Player),
    enemies: Array(Enemy),
  )
end
