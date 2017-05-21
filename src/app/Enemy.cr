class Enemy
  def initialize(x : Float64, y : Float64, z : Float64)
    @id = SecureRandom.uuid
    @position = Position.new(x, y, z)
    @isVisible = true
  end

  def self.random
    random = Random.new
    new(random.rand(-20.00..20.00), random.rand(3.00..8.00), random.rand(-20.00..20.00))
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
