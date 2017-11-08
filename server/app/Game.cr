class Game
  property players_number = 0
  getter scene = Scene.new
  getter status : String = GAME_STATUS[:NEW_GAME]
  
  def set_players_number(players_number : Int32)
    @players_number = players_number
    
    if players_number > 1
      @status = GAME_STATUS[:WAITING_FOR_PLAYERS]
    else
      @status = GAME_STATUS[:PLAYING]
    end
  end
  
  def add_player_with_enemies(player : Player)
    @scene.add_player_with_enemies(player, SETTINGS[:ENEMIES_NUMBER])
    
    if @scene.players.size >= @players_number
      @status = GAME_STATUS[:PLAYING]
    end
  end

  def can_start
    if is_waiting_for_players
      ready_players = @scene.players.count do |player| 
        player.status == PLAYER[:STATUS][:STARTING_GAME]
      end
      
      waiting_players = @scene.players.count do |player| 
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
    @scene.players.any? do |player| 
      player.points >= SETTINGS[:POINTS_NUMBER_TO_WIN]
    end
  end
end
