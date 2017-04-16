'use strict';

require('./components/enemyHoverListener.js');

var Elm = require('./Main.elm');
var mountNode = document.getElementById('main');
var app = Elm.Main.embed(mountNode);

window.elmApp = app;
