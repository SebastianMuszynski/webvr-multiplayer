class Enemy
  getter id = SecureRandom.uuid
  @color = PLAYER[:DEFAULT_COLOR]
  @is_alive = true

  def initialize(x : Float32, y : Float32, z : Float32)
    @position = Position.new(x, y, z)
  end

  def self.random
    random = Random.new
    new(random.rand(-20.00..20.00).to_f32,
      random.rand(3.00..8.00).to_f32,
      random.rand(-20.00..20.00).to_f32)
  end

  def hide
    @is_alive = false
  end

  def is_dead
    !@is_alive
  end

  JSON.mapping(
    id: String,
    is_alive: Bool,
    color: String,
    position: Position,
  )
end
