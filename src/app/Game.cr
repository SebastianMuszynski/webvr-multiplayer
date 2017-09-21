class Game
  def initialize
    @scene = Scene.new
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
    self.add_enemies_for_player(INITIAL_ENEMIES_NUMBER, player)
  end

  def add_enemies_for_player(enemies_number : Int32, player : Player)
    @scene.add_enemies_for_player(enemies_number, player)
  end

  def add_enemy_for_player(player : Player)
    @scene.add_enemies_for_player(1, player)
  end

  def get_player(player_id : String)
    @scene.get_player(player_id)
  end

  def set_player_as_ready_to_play(player : Player)
    @scene.set_player_as_ready_to_play(player)
  end

  def can_start_game
    @scene.can_start_game
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
