AFRAME.registerComponent('player-position-listener', {
  init: function () {
    var player = this.el;
    var scene = player.sceneEl;
    var playerId = scene.getAttribute("data-player-id");

    player.addEventListener('componentchanged', function (evt) {
      var propChanged = evt.detail.name;
      
      // Track only rotation
      // var hasPositionChanged = propChanged == 'position' || propChanged == 'rotation';
      
      var hasPositionChanged = propChanged == 'rotation';

      if (!hasPositionChanged) {
        return;
      }

      var playerPosition = player.getAttribute('position');
      var playerRotation = player.getAttribute('rotation');

      playerRotation.x = Math.floor(playerRotation.x);
      playerRotation.y = Math.floor(playerRotation.y);
      playerRotation.z = 0;
      
      // Turned off - its buggy on mobile
      // playerRotation.z = Math.floor(playerRotation.z);

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
    });
  }
});
