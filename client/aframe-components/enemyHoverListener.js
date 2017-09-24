AFRAME.registerComponent('enemy-hover-listener', {
  init: function () {
    var enemy = this.el;
    var scene = enemy.sceneEl;
    var playerId = scene.getAttribute("data-player-id");
    var playerColor = scene.getAttribute("data-player-color");
    
    this.el.addEventListener('click', function() {
      enemy.components.sound.playSound();
      var enemyColor = this.getAttribute("data-color");
      if (playerColor != enemyColor) return;      
      var enemyId = this.getAttribute("data-id");
      var action = {
        type_: "REMOVE_ENEMY",
        payload: {
          data: enemyId,
          player_id: playerId || ""
        }
      };
      window.elmApp.ports.fromJs.send(JSON.stringify(action));
    });
  }
});
