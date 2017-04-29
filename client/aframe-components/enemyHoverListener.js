AFRAME.registerComponent('enemy-hover-listener', {
  init: function () {
    var enemy = this.el;
    enemy.addEventListener('mouseenter', function() {
      var enemyId = enemy.getAttribute("data-id");
      var action = {
        type_: "REMOVE_ENEMY_REQUEST",
        payload: enemyId
      };
      window.elmApp.ports.fromJs.send(JSON.stringify(action));
    });
  }
});
