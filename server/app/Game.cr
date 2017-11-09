class Game
  property players_number = 0
  getter status : String = GAME_STATUS[:NEW_GAME]
  getter players = [] of Player
  getter enemies = [] of Enemy
  
  def initialize
  end

  def can_start
    if is_waiting_for_players
      ready_players = @players.count do |player|
        player.status == PLAYER[:STATUS][:STARTING_GAME]
      end

      waiting_players = @players.count do |player|
        player.status == PLAYER[:STATUS][:NEW_PLAYER]
      end

      if ready_players + waiting_players >= @players_number
        return @status == GAME_STATUS[:PLAYING]
      end
    end

    false
  end

  def is_waiting_for_players
    @status == GAME_STATUS[:WAITING_FOR_PLAYERS]
  end

  def is_over
    @players.any? do |player|
      player.points >= SETTINGS[:POINTS_NUMBER_TO_WIN]
    end
  end
  
  def set_players_number(players_number : Int32)
    @players_number = players_number

    if players_number > 1
      @status = GAME_STATUS[:WAITING_FOR_PLAYERS]
    else
      @status = GAME_STATUS[:PLAYING]
    end
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

  def get_new_player_color
    colors = PLAYER[:COLORS]
    colors[@players.size % colors.size]
  end

  def get_new_player_position
    player_positions[@players.size % player_positions.size]
  end

  def add_player_with_enemies(player : Player, enemies_number : Int32)
    player.color = get_new_player_color()
    player.position = get_new_player_position()
    
    add_player_enemies(player, enemies_number)
    @players << player
    
    if @players.size >= @players_number
      @status = GAME_STATUS[:PLAYING]
    end
  end

  def add_player_enemies(player : Player, enemies_number : Int32)
    while enemies_number > 0
      enemy = Enemy.random
      enemy.color = player.color
      @enemies << enemy
      enemies_number -= 1
    end
  end
  
  def remove_player_with_enemies(player : Player)
    remove_player_enemies(player)
    @players.delete(player)
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
