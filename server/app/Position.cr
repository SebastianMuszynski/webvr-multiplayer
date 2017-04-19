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

  JSON.mapping(
    x: Float64,
    y: Float64,
    z: Float64,
  )
end
