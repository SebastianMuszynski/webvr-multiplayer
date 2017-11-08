class Enemy
  getter id = SecureRandom.uuid
  @color = PLAYER[:DEFAULT_COLOR]
  @isVisible = true

  def initialize(x : Float64, y : Float64, z : Float64)
    @position = Position.new(x, y, z)
  end

  def self.random
    random = Random.new
    new(random.rand(-20.00..20.00),
      random.rand(3.00..8.00),
      random.rand(-20.00..20.00))
  end

  def hide
    @isVisible = false
  end

  def is_dead
    !@isVisible
  end

  JSON.mapping(
    id: String,
    position: Position,
    isVisible: Bool,
    color: String
  )
end
