require "kemal"
require "uuid"

require "./app/Action"
require "./app/Enemy"
require "./app/Player"
require "./app/Position"
require "./app/Scene"

require "./routes"
require "./websockets"

Kemal.run
