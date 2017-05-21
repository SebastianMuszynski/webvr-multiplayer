AFRAME.registerComponent('player-position-listener', {
  tick: function (time) {
    var player = this.el;
    var scene = player.sceneEl;
    var playerId = scene.getAttribute("data-player-id");

    if (time - this.time < 200) {
      return;
    }

    this.time = time;

    var playerPosition = player.getAttribute('position');

    var action = {
      type_: "PLAYER_POSITION_CHANGED",
      payload: {
        data: JSON.stringify(playerPosition),
        player_id: playerId || ""
      }
    };
    window.elmApp.ports.fromJs.send(JSON.stringify(action));
  }
});
