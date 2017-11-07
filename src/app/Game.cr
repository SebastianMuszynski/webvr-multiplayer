class Game
  INT32_MAX = 2147483647
  @status : String
  
  def initialize
    @scene = Scene.new
    @status = GAME_STATUS[:NEW_GAME]
    @players_number = INT32_MAX
  end
  
  def set_players_number(players_number : Int32)
    @players_number = players_number
    
    if players_number > 1
      @status = GAME_STATUS[:WAITING_FOR_PLAYERS]
    else
      @status = GAME_STATUS[:PLAYING]
    end
  end
  
  def scene
    @scene
  end

  def players
    @scene.players
  end
  
  def enemies
    @scene.enemies
  end

  def add_player(player : Player)
    @scene.add_player(player)
    @scene.add_player_enemies(player, SETTINGS[:ENEMIES_NUMBER])
    
    if self.players.size >= @players_number
      @status = GAME_STATUS[:PLAYING]
    end
  end

  def add_enemy_for_player(player : Player)
    @scene.add_player_enemies(player, 1)
  end

  def can_start_game
    @status == GAME_STATUS[:PLAYING]
  end
  
  def is_waiting_for_players
    @status == GAME_STATUS[:WAITING_FOR_PLAYERS]
  end

  def is_over
    @scene.players.any? do |player| 
      player.points >= SETTINGS[:POINTS_NUMBER_TO_WIN]
    end
  end

  def remove_player(player)
    @scene.remove_player(player)
  end
end
