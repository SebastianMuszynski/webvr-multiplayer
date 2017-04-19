require "kemal"
require "uuid"

require "./Action"
require "./Enemy"
require "./Player"
require "./Position"
require "./Scene"

require "./routes"
require "./websockets"

Kemal.run
