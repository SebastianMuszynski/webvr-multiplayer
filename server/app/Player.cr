class Player
  property position = Position.new
  property rotation = Rotation.new
  @id = SecureRandom.uuid
  @color = PLAYER[:DEFAULT_COLOR]
  @points = PLAYER[:DEFAULT_POINTS].to_u16
  @status = PLAYER[:STATUS][:NEW_PLAYER]

  def initialize(@socket : HTTP::WebSocket)
  end

  def start_game
    if @status == PLAYER[:STATUS][:NEW_PLAYER]
      @status = PLAYER[:STATUS][:WAITING_FOR_OTHERS]
    else
      @status = PLAYER[:STATUS][:PLAYING]
    end
  end

  def add_point
    @points += 1
  end

  JSON.mapping(
    socket: {type: HTTP::WebSocket, converter: WebSocketConverter},
    id: String,
    status: String,
    points: UInt16,
    color: String,
    position: Position,
    rotation: Rotation,
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
