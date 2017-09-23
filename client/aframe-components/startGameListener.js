AFRAME.registerComponent('start-game-listener', {
  schema: {
    playersNumber: {type: 'int', default: 1}
  },
  init: function () {
    let enemy = this.el;
    let scene = enemy.sceneEl;
    let playerId = scene.getAttribute("data-player-id");
    let playersNumber = this.data.playersNumber;

    this.el.addEventListener('mouseenter', function() {
      let action = {
        type_: "START_GAME",
        payload: {
          data: "" + playersNumber,
          player_id: playerId || "",
        }
      };
      window.elmApp.ports.fromJs.send(JSON.stringify(action));
    });
  }
});
