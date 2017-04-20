class Player
  def initialize(x : Float64, y : Float64, z : Float64)
    @id = SecureRandom.uuid
    @position = Position.new(x, y, z)
  end

  def self.random
    random = Random.new
    range = 1.0..8.0
    groundHeight = 0.6
    new(random.rand(range), groundHeight, random.rand(range))
  end

  def id
    @id ||= SecureRandom.uuid
  end

  JSON.mapping(
    id: String,
    position: { type: Position, nilable: false }
  )
end
