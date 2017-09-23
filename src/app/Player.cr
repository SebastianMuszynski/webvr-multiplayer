class Player
  def initialize(@socket : HTTP::WebSocket)
    @id = SecureRandom.uuid
    @player_settings = PlayerSettings.new
    @status = GAME_STATUS[:NEW_PLAYER]
    @points = 0
    @color = SETTINGS[:PLAYER_COLOR]
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
    if @status == GAME_STATUS[:NEW_PLAYER]
      @status = GAME_STATUS[:STARTING_GAME]
    else
      @status = GAME_STATUS[:PLAYING]
    end
  end

  def add_points(number)
    @points += number
  end

  def add_point
    self.add_points(1)
  end
  
  def is_ready_to_play
    @status == GAME_STATUS[:STARTING_GAME]
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