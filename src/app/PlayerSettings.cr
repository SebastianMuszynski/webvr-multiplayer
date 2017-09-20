class PlayerSettings
  def initialize(@position : Position, @rotation : Rotation)
  end

  JSON.mapping(
    position: {type: Position, nilable: false},
    rotation: {type: Rotation, nilable: false}
  )
end
