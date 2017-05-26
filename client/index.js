'use strict';

require('./aframe-components/enemyHoverListener.js');
require('./aframe-components/playerPositionListener.js');
require('./aframe-components/modelAnimation.js');

var Elm = require('./Main.elm');
var mountNode = document.getElementById('main');
var app = Elm.Main.embed(mountNode, {
  host: process.env.HOST
});

window.elmApp = app;
