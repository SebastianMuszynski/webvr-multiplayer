require "kemal"
require "uuid"

require "./app/Action"
require "./app/Enemy"
require "./app/Game"
require "./app/Player"
require "./app/Position"
require "./app/Rotation"
require "./app/Scene"

require "./helpers/ActionHelper"
require "./helpers/SocketsHelper"

require "./services/AddPlayer"
require "./services/RemoveEnemy"
require "./services/RemovePlayer"
require "./services/StartGame"
require "./services/UpdatePlayerPosition"
require "./services/UpdatePlayerRotation"

require "./constants"
require "./routes"
require "./websockets"

Kemal.run
