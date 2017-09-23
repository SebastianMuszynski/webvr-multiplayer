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
    self.add_enemies_for_player(SETTINGS[:ENEMIES_NUMBER], player)
    
    if self.players.size >= @players_number
      @status = GAME_STATUS[:PLAYING]
    end
  end

  def add_enemies_for_player(enemies_number : Int32, player : Player)
    @scene.add_enemies_for_player(enemies_number, player)
  end

  def add_enemy_for_player(player : Player)
    @scene.add_enemies_for_player(1, player)
  end
  
  def get_new_player_position
    @scene.get_new_player_position
  end
  
  def get_new_player_color
    @scene.get_new_player_color
  end

  def get_player(player_id : String)
    @scene.get_player(player_id)
  end

  def set_player_as_ready_to_play(player : Player)
    @scene.set_player_as_ready_to_play(player)
  end

  def can_start_game
    @status == GAME_STATUS[:PLAYING]
  end
  
  def is_waiting_for_players
    @status == GAME_STATUS[:WAITING_FOR_PLAYERS]
  end

  def is_over
    @scene.is_game_over
  end

  def remove_enemy_by_id(enemy_id)
    @scene.remove_enemy_by_id(enemy_id)
  end

  def remove_player(player)
    @scene.remove_player(player)
  end
end
