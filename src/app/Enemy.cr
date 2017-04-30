class Enemy
  def initialize(x : Float64, y : Float64, z : Float64)
    @id = SecureRandom.uuid
    @position = Position.new(x, y, z)
    @isVisible = true
  end

  def self.random
    random = Random.new
    range = 1.0..8.0
    new(random.rand(range), random.rand(range), random.rand(range))
  end

  def id
    @id ||= SecureRandom.uuid
  end

  def hide
    @isVisible = false
  end

  JSON.mapping(
    id: String,
    position: { type: Position, nilable: false },
    isVisible: Bool
  )
end
