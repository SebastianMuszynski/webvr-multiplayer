class Player
  # @socket = uninitialized HTTP::WebSocket

  # def initialize(x : Float64, y : Float64, z : Float64, color : String)
  def initialize(@socket : HTTP::WebSocket)
    @id = SecureRandom.uuid
    @player_settings = PlayerSettings.new
    @status = STATUS_NEW_PLAYER
    @points = 0
    @color = "#000"
  end

  def set_color(color : String)
    @color = color
  end
  
  def set_position(position : Position)
    @player_settings.set_position(position)
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
    self.add_points(1)
  end
  
  # def set_as_ready_to_play
  #   @is_ready_to_play = true
  # end
  #
  def is_ready_to_play
    @status == STATUS_STARTING_GAME
  end

  JSON.mapping(
    socket: {type: HTTP::WebSocket, converter: WebSocketConverter},
    id: String,
    player_settings: PlayerSettings,
    status: Int32,
    points: Int32,
    color: String
  )
end

# Ideally would be to ignore the socket being sent to the client
module WebSocketConverter
  def self.from_json(value : JSON::PullParser) : String
    "socket"
  end
  
  def self.to_json(value : HTTP::WebSocket, json : JSON::Builder)
    json.string("socket")
  end
end