AFRAME.registerComponent('move-player', {
  init: function () {
    var player = this.el;
    var scene = player.sceneEl;
    var playerId = scene.getAttribute("data-player-id");

    player.addEventListener('componentchanged', function (evt) {
      var propChanged = evt.detail.name;
      
      var hasPositionChanged = propChanged == 'position';
      var hasRotationChanged = propChanged == 'rotation';
      
      if (hasPositionChanged || hasRotationChanged) {
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
          type_: "UPDATE_POSITION",
          payload: {
            data: JSON.stringify(playerSettings),
            player_id: playerId || ""
          }
        };

        window.elmApp.ports.fromJs.send(JSON.stringify(action));
      }
    });
  }
});
