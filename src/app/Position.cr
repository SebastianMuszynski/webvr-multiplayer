class Position
  property :x 
  property :y 
  property :z
  
  def initialize(@x = 0.0, @y = 0.0, @z = 0.0)
  end

  JSON.mapping(
    x: Float64,
    y: Float64,
    z: Float64,
  )
end
