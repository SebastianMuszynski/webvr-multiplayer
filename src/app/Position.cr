class Position
  def initialize(@x : Float64, @y : Float64, @z : Float64)
  end

  def x
    @x ||= 0
  end

  def x=(value)
    @x = value
  end

  def y
    @y ||= 0
  end

  def y=(value)
    @y = value
  end

  def z
    @z ||= 0
  end

  def z=(value)
    @z = value
  end

  def self.random
    random = Random.new
    range = 1.0..8.0
    new(random.rand(range), random.rand(range), random.rand(range))
  end

  JSON.mapping(
    x: Float64,
    y: Float64,
    z: Float64,
  )
end
