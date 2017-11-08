'use strict';

require('./action-listeners/shoot-enemy.js');
require('./action-listeners/move-player.js');
require('./action-listeners/start-game.js');

var Elm = require('./Main.elm');
var mountNode = document.getElementById('main');
var app = Elm.Main.embed(mountNode, {
  host: process.env.HOST
});

window.elmApp = app;
