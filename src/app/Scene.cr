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
  
  def set_player_as_ready_to_play(player_id)
    player = get_player_by_id(player_id)
    player && player.set_as_ready_to_play
  end

  def get_player_by_id(player_id)
    @players.find { |player| player.id == player_id }
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
  
  def can_start_game
    @players.all? { |player| player.is_ready_to_play } 
  end

  JSON.mapping(
    players: Array(Player),
    enemies: Array(Enemy),
  )
end
