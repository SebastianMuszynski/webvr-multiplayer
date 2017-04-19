class Scene
  def initialize(players : Array(Player), enemies : Array(Enemy))
    @players = players
    @enemies = enemies
  end

  def players
    @players
  end

  def players=(value)
    @players = value
  end

  def enemies
    @enemies
  end

  def enemies=(value)
    @enemies = value
  end

  def add_player(player)
    @players << player
  end

  JSON.mapping(
    players: Array(Player),
    enemies: Array(Enemy),
  )
end
