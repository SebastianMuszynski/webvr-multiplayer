AFRAME.registerComponent('move-player', {
  init: function () {
    var player = this.el;
    var scene = player.sceneEl;
    var playerId = scene.getAttribute("data-player-id");
  
    player.addEventListener('componentchanged', function (evt) {
      var propChanged = evt.detail.name;
      var hasPositionChanged = propChanged == 'position';
      if (hasPositionChanged) {
        var playerPosition = player.getAttribute('position');
  
        var action = {
          type_: "UPDATE_POSITION",
          payload: {
            data: JSON.stringify(playerPosition),
            player_id: playerId || ""
          }
        };
  
        window.elmApp.ports.fromJs.send(JSON.stringify(action));
      }
    });
  }
});
