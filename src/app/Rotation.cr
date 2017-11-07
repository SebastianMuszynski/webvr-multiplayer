class Rotation
  property :x
  property :y
  property :z
  
  def initialize(@x = 0, @y = 0, @z = 0)
  end

  JSON.mapping(
    x: Int32,
    y: Int32,
    z: Int32,
  )
end
