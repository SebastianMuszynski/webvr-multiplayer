require "kemal"
require "uuid"

require "./app/Action"
require "./app/Enemy"
require "./app/Player"
require "./app/PlayerSettings"
require "./app/Position"
require "./app/Rotation"
require "./app/Scene"

require "./helpers/SocketsHelper"

require "./services/StartGameService"
require "./services/AddPlayerService"
require "./services/UpdatePlayersPositionService"
require "./services/RemoveEnemyService"
require "./services/RemovePlayerService"

require "./constants"
require "./routes"
require "./websockets"

Kemal.run
