class PlayerSettings
  def initialize
    @position = Position.new(0.0, 0.0, 0.0)
    @rotation = Rotation.new(0, 0, 0)
  end
  
  def set_position(position : Position)
    @position = position
  end

  def set_rotation(rotation : Rotation)
    @rotation = rotation
  end

  JSON.mapping(
    position: Position,
    rotation: Rotation
  )
end
