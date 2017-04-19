class Position
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
    x: Float32,
    y: Float32,
    z: Float32,
  )
end
