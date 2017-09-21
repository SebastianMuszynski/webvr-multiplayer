class Player
  # @socket = uninitialized HTTP::WebSocket

  # def initialize(x : Float64, y : Float64, z : Float64, color : String)
  def initialize(@socket : HTTP::WebSocket)
    @id = SecureRandom.uuid
    @player_settings = PlayerSettings.new
    @status = STATUS_NEW_PLAYER
    @points = 0
    # @is_ready_to_play = false
  end
  
  def set_color(color : String)
    @color = color
  end
  
  def set_position(position : Position)
    @player_settings.position = position
  end
  
  def set_rotation(rotation : Rotation)
    @player_settings.rotation = rotation
  end
  
  def set_settings(settings : PlayerSettings)
    @player_settings = settings
  end
  
  def start_game
    if @status == STATUS_NEW_PLAYER
      @status = STATUS_STARTING_GAME
    else
      @status = STATUS_PLAYING
    end
  end

  # def assign_socket(socket)
  #   @socket = socket
  # end

  # def socket
  #   @socket
  # end

  # def self.random
  #   random = Random.new
  #   range = 1.0..8.0
  #   groundHeight = 0.6
  #   new(random.rand(range), groundHeight, random.rand(range))
  # end

  # def id
  #   @id ||= SecureRandom.uuid
  # end

  def add_points(number)
    @points += number
  end
  
  def add_point
    self.add_point(1)
  end

  # def set_player_settings(player_settings : PlayerSettings)
  #   pos = player_settings.position
  # TODO: BUGGG! DON'T CHANGE POSITION BASED ON ROTATION
  #   pos.x = pos.x + player_settings.rotation.z
  #   player_settings.position = pos
  #   @player_settings = player_settings
  # end
  # 
  # def set_as_ready_to_play
  #   @is_ready_to_play = true
  # end
  # 
  # def is_ready_to_play
  #   @is_ready_to_play
  # end

  # JSON.mapping(
  #   id: String,
  #   player_settings: {type: PlayerSettings, nilable: false},
  #   points: Int32,
  #   is_ready_to_play: Bool,
  #   color: String
  # )

  JSON.mapping(
    id: String,
    player_settings: {type: PlayerSettings, nilable: false},
    status: Int32,
    points: Int32,
    color: String
  )
end
