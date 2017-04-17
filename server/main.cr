require "kemal"
require "uuid"

class Position
  JSON.mapping(
    x: Float32,
    y: Float32,
    z: Float32,
  )
end

class Player
  def generate_id
    @id ||= SecureRandom.uuid
  end

  JSON.mapping(
    position: { type: Position, nilable: false }
  )
end

class Enemy
  JSON.mapping(
    position: { type: Position, nilable: false }
  )
end

class Action
  JSON.mapping(
    type_: String,
    payload: String
  )
end

class Scene
  @@sockets = [] of HTTP::WebSocket
  @@players = [] of Player
  @@enemies = [] of Enemy

  def self.sockets
    @@sockets
  end

  def self.sockets=(value)
    @@sockets = value
  end

  def self.players
    @@players
  end

  def self.players=(value)
    @@players = value
  end

  def self.enemies
    @@enemies
  end

  def self.enemies=(value)
    @@enemies = value
  end

  def self.add_player(player)
    @@players << player
  end

  JSON.mapping(
    players: Array(Player),
    enemies: Array(Enemy),
  )
end


ws "/room" do |socket|
  Scene.sockets << socket

  socket.on_message do |message|
    # Decode action
    action = Action.from_json(message)

    case action.type_
    when "NEW_PLAYER"
      Scene.add_player(Player.from_json(action.payload))
    else
      p "Unrecognised action type: #{action.type_}"
    end

    # Broadcast players
    Scene.sockets.each do |socket|
      socket.send Scene.players.to_json
    end
  end

  socket.on_close do
    Scene.sockets.delete socket
  end
end

# Routes

get "/" do
  render "public/index.ecr"
end

Kemal.run
