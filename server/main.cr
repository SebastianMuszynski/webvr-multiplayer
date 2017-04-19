require "kemal"
require "uuid"

class Position
  def x
    @x ||= 0
  end

  def x=(value)
    @x = value
  end

  def y
    @y ||= 0
  end

  def y=(value)
    @y = value
  end

  def z
    @z ||= 0
  end

  def z=(value)
    @z = value
  end

  JSON.mapping(
    x: Float32,
    y: Float32,
    z: Float32,
  )
end

class Player
  def id
    @id ||= SecureRandom.uuid
  end

  JSON.mapping(
    position: { type: Position, nilable: false }
  )
end

class Enemy
  def id
    @id ||= SecureRandom.uuid
  end

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

  def initialize(players : Array(Player), enemies : Array(Enemy))
    @players = players
    @enemies = enemies
  end

  def players
    @players
  end

  def players=(value)
    @players = value
  end

  def enemies
    @enemies
  end

  def enemies=(value)
    @enemies = value
  end

  def add_player(player)
    @players << player
  end

  JSON.mapping(
    players: Array(Player),
    enemies: Array(Enemy),
  )
end

SOCKETS = [] of HTTP::WebSocket

# Init the scene
SCENE = Scene.new(Array(Player).new, Array(Enemy).new)

ws "/room" do |socket|
  SOCKETS << socket

  socket.on_message do |message|
    # Decode action
    action = Action.from_json(message)

    case action.type_
    when "NEW_PLAYER"
      player = Player.from_json(action.payload)
      SCENE.add_player(player)
    else
      p "Unrecognised action type: #{action.type_}"
    end

    # Broadcast players
    SOCKETS.each do |socket|
      socket.send SCENE.players.to_json
    end
  end

  socket.on_close do
    SOCKETS.delete socket
  end
end

# Routes

get "/" do
  render "public/index.ecr"
end

Kemal.run
