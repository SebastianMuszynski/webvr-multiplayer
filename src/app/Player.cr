class Player
  def initialize(@socket : HTTP::WebSocket)
    @id = SecureRandom.uuid
    @player_settings = PlayerSettings.new
    @status = PLAYER[:STATUS][:NEW_PLAYER]
    @points = 0
    @color = PLAYER[:DEFAULT_COLOR]
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
    if @status == PLAYER[:STATUS][:NEW_PLAYER]
      @status = PLAYER[:STATUS][:STARTING_GAME]
    else
      @status = PLAYER[:STATUS][:PLAYING]
    end
  end

  def add_points(number)
    @points += number
  end

  def add_point
    self.add_points(1)
  end
  
  def points
    @points
  end
  
  def is_ready_to_play
    @status == PLAYER[:STATUS][:STARTING_GAME]
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

module WebSocketConverter
  def self.from_json(value : JSON::PullParser) : String
    "socket"
  end
  
  def self.to_json(value : HTTP::WebSocket, json : JSON::Builder)
    json.string("socket")
  end
end