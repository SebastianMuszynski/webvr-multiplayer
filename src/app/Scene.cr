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
  
  def get_new_player_position
    dist = 7.0
    zero = 0.0
    positions = [
      Position.new( zero, zero,  dist), 
      Position.new( zero, zero, -dist), 
      Position.new(-dist, zero,  zero), 
      Position.new( dist, zero,  zero)
    ]
    positions[@players.size % positions.size]
  end
  
  def remove_player_by_socket(socket)
    player = @players.find { |player| player.socket == socket }
    player && @players.delete player
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
  
  def is_game_over
    @enemies.all? { |enemy| enemy.is_dead } 
  end

  JSON.mapping(
    players: Array(Player),
    enemies: Array(Enemy),
  )
end
