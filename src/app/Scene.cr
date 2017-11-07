class Scene
  def initialize
    @players = [] of Player
    @enemies = [] of Enemy
  end

  def players
    @players
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
    colors = [
      "#F39237",
      "#BF1363",
      "#E6C229",
      "#81559B",
    ]
    colors[@players.size % colors.size]
  end

  def get_new_player_position
    dist = 7.0
    zero = 0.0
    positions = [
      Position.new(zero, zero, dist),
      Position.new(zero, zero, -dist),
      Position.new(-dist, zero, zero),
      Position.new(dist, zero, zero),
    ]
    positions[@players.size % positions.size]
  end

  def remove_player(player : Player)
    self.remove_player_enemies(player)
    @players.delete(player)
  end
  
  def remove_player_enemies(player : Player)
    @enemies.reject! { |enemy| enemy.color == player.color }
  end

  def set_player_as_ready_to_play(player_id : String)
    player = get_player(player_id)
    player && player.set_as_ready_to_play
  end

  def get_player(player_id : String)
    @players.find { |player| player.id == player_id }
  end

  def enemies
    @enemies
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
