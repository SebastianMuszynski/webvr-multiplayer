class Player
  def initialize(x : Float64, y : Float64, z : Float64)
    @id = SecureRandom.uuid
    @player_settings = PlayerSettings.new(
      Position.new(x, y, z),
      Rotation.new(0, 0, 0)
    )
    @points = 0
  end

  def self.random
    random = Random.new
    range = 1.0..8.0
    groundHeight = 0.6
    new(random.rand(range), groundHeight, random.rand(range))
  end

  def id
    @id ||= SecureRandom.uuid
  end

  def add_points(number)
    @points += number
  end

  def set_player_settings(player_settings : PlayerSettings)
    pos = player_settings.position
    pos.x = pos.x + player_settings.rotation.z
    player_settings.position = pos
    @player_settings = player_settings
  end

  JSON.mapping(
    id: String,
    player_settings: { type: PlayerSettings, nilable: false },
    points: Int32
  )
end
