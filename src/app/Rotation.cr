class Rotation
  def initialize(@x : Int32, @y : Int32, @z : Int32)
  end

  JSON.mapping(
    x: Int32,
    y: Int32,
    z: Int32,
  )
end
