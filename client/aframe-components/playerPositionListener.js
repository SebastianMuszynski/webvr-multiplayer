AFRAME.registerComponent('player-position-listener', {
  tick: function (time) {
    var player = this.el;
    var scene = player.sceneEl;
    var playerId = scene.getAttribute("data-player-id");

    if (time - this.time < 50) {
      return;
    }

    this.time = time;

    var playerPosition = player.getAttribute('position');
    var playerRotation = player.getAttribute('rotation');

    playerRotation.x = Math.floor(playerRotation.x);
    playerRotation.y = Math.floor(playerRotation.y);
    playerRotation.z = Math.floor(playerRotation.z);

    var playerSettings = {
      position: playerPosition,
      rotation: playerRotation,
    };

    var action = {
      type_: "PLAYER_POSITION_CHANGED",
      payload: {
        data: JSON.stringify(playerSettings),
        player_id: playerId || ""
      }
    };
    window.elmApp.ports.fromJs.send(JSON.stringify(action));
  }
});
