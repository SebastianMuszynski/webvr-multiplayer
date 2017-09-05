class Player
  @socket = uninitialized HTTP::WebSocket
  
  def initialize(x : Float64, y : Float64, z : Float64, color : String)
    @id = SecureRandom.uuid
    @player_settings = PlayerSettings.new(
      Position.new(x, y, z),
      Rotation.new(0, 0, 0)
    )
    @points = 0
    @is_ready_to_play = false
    @color = color
  end
  
  def assign_socket(socket)
    @socket = socket
  end
  
  def socket
    @socket
  end
  
  def color
    @color
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
  
  def set_as_ready_to_play
    @is_ready_to_play = true
  end
  
  def is_ready_to_play
    @is_ready_to_play
  end

  JSON.mapping(
    id: String,
    player_settings: { type: PlayerSettings, nilable: false },
    points: Int32,
    is_ready_to_play: Bool,
    color: String
  )
end
