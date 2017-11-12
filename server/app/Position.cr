class Position
  property :x
  property :y
  property :z

  def initialize(@x = 0.0_f32, @y = 0.0_f32, @z = 0.0_f32)
  end

  JSON.mapping(
    x: Float32,
    y: Float32,
    z: Float32,
  )
end
