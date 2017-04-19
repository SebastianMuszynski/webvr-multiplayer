class Enemy
  def initialize(x : Float64, y : Float64, z : Float64)
    @id = SecureRandom.uuid
    @position = Position.new(x, y, z)
  end

  def self.random
    random = Random.new
    new(random.rand, random.rand, random.rand)
  end

  def id
    @id ||= SecureRandom.uuid
  end

  JSON.mapping(
    id: String,
    position: { type: Position, nilable: false }
  )
end
