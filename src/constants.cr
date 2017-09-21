################
# ## SETTINGS ###
################

INITIAL_PLAYER_POINTS  = 1
INITIAL_ENEMIES_NUMBER = 1

#####################
# ## PLAYER STATUS ###
#####################

# Player hasn't clicked Start Game button yet
STATUS_NEW_PLAYER = 0
# Player has clicked Start Game button and is waiting for others
STATUS_STARTING_GAME = 1
# Player is playing the game with others
STATUS_PLAYING = 2

########################
# ## CLIENT MSG TYPES ###
########################

MSG_NEW_PLAYER              = "NEW_PLAYER_REQUEST"
MSG_START_GAME              = "START_GAME_REQUEST"
MSG_PLAYER_POSITION_CHANGED = "PLAYER_POSITION_CHANGED"
MSG_REMOVE_ENEMY            = "REMOVE_ENEMY_REQUEST"
