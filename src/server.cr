require "kemal"
require "uuid"

require "./app/Action"
require "./app/Enemy"
require "./app/Player"
require "./app/PlayerSettings"
require "./app/Position"
require "./app/Rotation"
require "./app/Scene"

require "./services/StartGameService"
require "./services/NewPlayerService"

require "./routes"
require "./websockets"

Kemal.run
