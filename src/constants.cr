SETTINGS = {
  ENEMIES_NUMBER: 1,
  POINTS_NUMBER_TO_WIN: 10,
  # Scene's center point
  SCENE_CENTER: 0.0,
}

PLAYER = {
  DEFAULT_COLOR: "#000",
  DEFAULT_POINTS: 0,
  COLORS: [
    "#F39237",
    "#BF1363",
    "#E6C229",
    "#81559B",
  ],
  STATUS: {
    # Player has not clicked Start Game button yet
    NEW_PLAYER: "NEW_PLAYER",
    # Player has clicked Start Game button and is waiting for others
    STARTING_GAME: "STARTING_GAME",
    # Player is playing the game with others
    PLAYING: "PLAYING",
  },
  # A player's distance from the center of the scene in meters
  DISTANCE_FROM_CENTER: 7.0,
}

GAME_STATUS = {
  NEW_GAME: "NEW_GAME",
  WAITING_FOR_PLAYERS: "WAITING_FOR_PLAYERS",
  PLAYING: "PLAYING",
  GAME_OVER: "GAME_OVER", 
}

MSG = {
  NEW_PLAYER: "NEW_PLAYER",
  START_GAME: "START_GAME",
  UPDATE_POSITION: "UPDATE_POSITION",
  REMOVE_ENEMY: "REMOVE_ENEMY",
}

ACTION_TYPE = {
  NEW_PLAYER: "NEW_PLAYER",
  WAIT_FOR_PLAYERS: "WAIT_FOR_PLAYERS",
  START_GAME: "START_GAME",
  PLAYER: "PLAYER",
  PLAYERS: "PLAYERS",
  ENEMIES: "ENEMIES",
  GAME_OVER: "GAME_OVER",
}