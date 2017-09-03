AFRAME.registerComponent('start-game-listener', {
  init: function () {
    var enemy = this.el;
    var scene = enemy.sceneEl;
    var playerId = scene.getAttribute("data-player-id");

    this.el.addEventListener('mouseenter', function() {
      var action = {
        type_: "START_GAME_REQUEST",
        payload: {
          data: "",
          player_id: playerId || ""
        }
      };
      window.elmApp.ports.fromJs.send(JSON.stringify(action));
      console.log("START GAME");
    });
  }
});
