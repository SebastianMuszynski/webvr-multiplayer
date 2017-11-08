AFRAME.registerComponent('rotate-player', {
  init: function () {
    var player = this.el;
    var scene = player.sceneEl;
    var playerId = scene.getAttribute("data-player-id");

    player.addEventListener('componentchanged', function (evt) {
      var propChanged = evt.detail.name;
      var hasRotationChanged = propChanged == 'rotation';
      if (hasRotationChanged) {
        var playerRotation = player.getAttribute('rotation');

        playerRotation.x = Math.floor(playerRotation.x);
        playerRotation.y = Math.floor(playerRotation.y);
        playerRotation.z = Math.floor(playerRotation.z);

        var action = {
          type_: "UPDATE_ROTATION",
          payload: {
            data: JSON.stringify(playerRotation),
            player_id: playerId || ""
          }
        };

        window.elmApp.ports.fromJs.send(JSON.stringify(action));
      }
    });
  }
});
