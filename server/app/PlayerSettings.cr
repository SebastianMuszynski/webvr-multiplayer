class PlayerSettings
  property :position
  property :rotation

  def initialize(@position = Position.new, @rotation = Rotation.new)
  end

  JSON.mapping(
    position: Position,
    rotation: Rotation
  )
end
