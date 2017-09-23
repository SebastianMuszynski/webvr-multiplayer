SETTINGS = {
  PLAYER_COLOR: "#000",
  ENEMIES_NUMBER: 1,
}

GAME_STATUS = {
  # Player hasn't clicked Start Game button yet
  NEW_PLAYER: 0,
  # Player has clicked Start Game button and is waiting for others
  STARTING_GAME: 1,
  # Player is playing the game with others
  PLAYING: 2,
}

MSG = {
  NEW_PLAYER: "NEW_PLAYER_REQUEST",
  START_GAME: "START_GAME_REQUEST",
  PLAYER_POSITION_CHANGED: "PLAYER_POSITION_CHANGED",
  REMOVE_ENEMY: "REMOVE_ENEMY_REQUEST",
}

ACTION_TYPE = {
  NEW_PLAYER: "NEW_PLAYER_RESPONSE",
  PLAYERS: "PLAYERS",
  ENEMIES: "ENEMIES",
  PLAYER: "PLAYER",
  WAIT_FOR_PLAYERS: "WAIT_FOR_PLAYERS",
  START_GAME: "START_GAME",
  GAME_OVER: "GAME_OVER",
}