AFRAME.registerComponent('enemy-hover-listener', {
  init: function () {
    var enemy = this.el;
    var scene = enemy.sceneEl;
    var playerId = scene.getAttribute("data-player-id");

    this.el.addEventListener('click', function() {
      var enemyId = this.getAttribute("data-id");
      var action = {
        type_: "REMOVE_ENEMY_REQUEST",
        payload: {
          data: enemyId,
          player_id: playerId || ""
        }
      };
      window.elmApp.ports.fromJs.send(JSON.stringify(action));
    });
  }
});
